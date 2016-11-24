class BookSuggestion < ApplicationRecord
  belongs_to :user

  validates :author, :title, :link, presence: true

  PERMITTED_PARAMS = [:title, :editorial, :price, :author, :link, :publisher, :year]
end
