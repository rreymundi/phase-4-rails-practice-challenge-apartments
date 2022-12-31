class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def create 
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = lease_find
        lease.destroy
        head :no_content
    end

    private

    def lease_find
        Lease.find(params[:id])
    end

    def lease_params 
        params.permit(:rent, :apartment_id, :tenant_id)
    end

    def record_not_found
        render json: { error: "Record not found" }, status: :not_found 
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end