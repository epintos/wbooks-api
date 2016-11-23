class BookSuggestionSerializer < ActiveModel::Serializer
  attributes :title, :author, :link

  has_one :user
end
