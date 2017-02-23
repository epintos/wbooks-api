class RentSimpleSerializer < ActiveModel::Serializer
  attributes :id, :from, :to, :user_id, :book_id
end
