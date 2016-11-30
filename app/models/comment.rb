class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, :user_id, :book_id, presence: true
end
