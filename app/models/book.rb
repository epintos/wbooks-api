class Book < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :rents
  has_many :wishes
  has_many :users, through: :wishes
  mount_uploader :image, ImageUploader
  validates :author, :title, :genre, :publisher, :year, presence: true
end
