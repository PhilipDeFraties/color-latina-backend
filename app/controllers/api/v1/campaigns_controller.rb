class Api::V1::CampaignsController < ApplicationController 
    def index
        begin
            @campaigns = Campaign.all
            render json: @campaigns.to_json
        rescue => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end
end