class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :genre, :publisher, :year, :id, :image_url, :description
end
