class Wish < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :user_id, :book_id, presence: true
end
