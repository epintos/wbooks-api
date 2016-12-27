class BookSerializer < ActiveModel::Serializer
  attributes :author, :title, :genre, :publisher, :year, :id, :image_url
end
