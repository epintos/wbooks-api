class Book < ApplicationRecord
  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader
  validates :author, :title, :genre, :publisher, :year, presence: true
end
