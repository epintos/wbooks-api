class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :author, :title, :genre, :publisher, :year, presence: true
end
