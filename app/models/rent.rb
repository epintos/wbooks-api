class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :from, :to, :user, :book, presence: true

  def in_progress
    from <= Date.current && to >= Date.current
  end
end
