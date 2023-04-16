class Api::V1::VolunteersController < ApplicationController 
    def index
        begin
            @volunteers = Volunteer.all
            render json: @volunteers.to_json
        rescue => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def show
        begin
            @volunteer = Volunteer.find(params[:id])
            render json: @volunteer.to_json(include: :campaigns)
        rescue ActiveRecord::RecordNotFound => e
            render json: { error: e.message }, status: :not_found
        end
    end
end