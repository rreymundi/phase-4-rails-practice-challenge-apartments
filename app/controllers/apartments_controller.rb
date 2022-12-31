class ApartmentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        apartments = Apartment.all 
        render json: apartments, status: :ok
    end

    def show 
        apartment = find_apt
        render json: apartment, status: :ok 
    end

    def create 
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :created
    end

    def update 
        apartment = find_apt
        apartment.update(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = find_apt
        apartment.destroy 
        head :no_content
    end

    private

    def find_apt
        Apartment.find(params[:id])
    end

    def apartment_params 
        params.permit(:number)
    end

    def record_not_found
        render json: { error: "Record not found" }, status: :not_found 
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
