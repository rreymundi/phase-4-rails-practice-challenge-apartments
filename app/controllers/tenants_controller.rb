class TenantsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid 

    def index 
        tenants = Tenant.all 
        render json: tenants, status: :ok 
    end

    def show 
        tenant = tenant_find
        render json: tenant, status: :ok
    end

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created 
    end

    def update 
        tenant = tenant_find
        tenant.update(tenant_params)
        render json: tenant, status: :ok 
    end

    def destroy 
        tenant = tenant_find
        tenant.destroy 
        head :no_content 
    end

    private 

    def tenant_find
        Tenant.find(params[:id])
    end

    def tenant_params 
        params.permit(:name, :age)
    end

    def record_not_found
        render json: { error: "Record not found" }, status: :not_found 
    end

    def record_invalid(invalid) 
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
    end

end
