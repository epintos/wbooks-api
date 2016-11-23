class WishSerializer < ActiveModel::Serializer
  has_one :book
  has_one :user
end
