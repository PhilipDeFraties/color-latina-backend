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

    def create
        @volunteer = Volunteer.new(volunteer_params)

        if @volunteer.save
            render json: @volunteer.to_json, status: :created
        else
            render json: { errors: @volunteer.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @volunteer = Volunteer.find(params[:id])

        if @volunteer.update(volunteer_params)
            render json: @volunteer.to_json
        else
            render json: { errors: @volunteer.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @volunteer = Volunteer.find(params[:id])
        if @volunteer.destroy
            head :no_content
        else
            render json: { errors: @volunteer.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def volunteer_params
        params.require(:volunteer).permit(:name, :email, :phone)
    end

    def record_not_found
        render json: { error: 'Record not found' }, status: :not_found
    end
end