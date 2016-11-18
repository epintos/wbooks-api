class WishSerializer < ActiveModel::Serializer
  attributes :user_id, :book_id

  has_one :book_id
  has_one :user_id
end
