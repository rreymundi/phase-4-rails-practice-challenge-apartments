class LeasesSerializer < ActiveModel::Serializer
  attributes :rent, :apartment_id, :tenant_id
end