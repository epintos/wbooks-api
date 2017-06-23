class RentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :returned_at

  has_one :book
  has_one :user
end
