class AddTenantIdAndApartmentIdToLeases < ActiveRecord::Migration[6.1]
  def change
    add_column :leases, :apartment_id, :integer
  end
end
