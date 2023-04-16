class Api::V1::CampaignsController < ApplicationController 
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
end