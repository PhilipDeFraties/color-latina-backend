class Api::V1::MessagesController < ApplicationController
  before_action :set_campaign
  before_action :set_message, only: [:show, :update, :destroy, :send_to_campaign_volunteers]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActionController::ParameterMissing, with: :render_bad_request_response

  def index
    messages = @campaign.messages
    render json: messages
  end

  def show
    render json: @message
  end

  def create
    message = @campaign.messages.create!(message_params)
    render json: message, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update
    @message.update!(message_params)
    render json: @message
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    @message.destroy
    head :no_content
  end

  def send_to_campaign_volunteers
    @campaign.send_message_to_volunteers(@message.id)

    render json: { message: "SMS messages sent successfully to campaign volunteers" }, status: :ok
    rescue StandardError => e
    	render json: { error: e.message }, status: :internal_server_error
	end

  private

  def set_campaign
    @campaign = Campaign.find_by(id: params[:campaign_id])
    render json: { error: "Campaign not found" }, status: :not_found unless @campaign
  end

  def set_message
    @message = @campaign.messages.find_by(id: params[:message_id])
    render json: { error: "Message not found" }, status: :not_found unless @message
  end

  def message_params
    params.require(:message).permit(:text)
  rescue ActionController::ParameterMissing
    render json: { error: "Missing message parameters" }, status: :bad_request
  end

  def render_not_found_response
    render json: { error: "Campaign not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def render_bad_request_response
    render json: { error: "Bad request" }, status: :bad_request
  end
end