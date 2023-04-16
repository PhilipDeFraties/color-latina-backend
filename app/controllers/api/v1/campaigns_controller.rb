class Api::V1::CampaignsController < ApplicationController 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        begin
            @campaigns = Campaign.all
            render json: @campaigns.to_json
        rescue => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def show
        begin
            @campaign = Campaign.find(params[:id])
            render json: @campaign.to_json(include: :volunteers)
        rescue ActiveRecord::RecordNotFound => e
            render json: { error: e.message }, status: :not_found
        end
    end

    def create
    @campaign = Campaign.new(campaign_params)

    if @campaign.save
      render json: @campaign.to_json, status: :created
    else
      render json: { errors: @campaign.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @campaign = Campaign.find(params[:id])

    if @campaign.update(campaign_params)
      render json: @campaign.to_json
    else
      render json: { errors: @campaign.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    
    if @campaign.destroy
      head :no_content
    else
      render json: { errors: @campaign.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :description, :start_date, :end_date)
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end