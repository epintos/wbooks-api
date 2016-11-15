class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :from, :to, :user, :book, presence: true
end
