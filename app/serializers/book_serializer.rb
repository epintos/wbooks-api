class BookSerializer < ActiveModel::Serializer
  attributes :author, :title, :genre, :publisher, :year
end
