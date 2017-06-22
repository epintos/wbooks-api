class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  has_one :book
  has_one :user
end
