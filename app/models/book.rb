class Book < ApplicationRecord
  has_many :comments

  mount_uploader :image, ImageUploader
  validates :author, :title, :genre, :publisher, :year, presence: true
end
