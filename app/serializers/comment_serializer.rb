class CommentSerializer < ActiveModel::Serializer
  attributes :content

  has_one :book
  has_one :user
end
