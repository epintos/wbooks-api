class BookSuggestion < ApplicationRecord
  validates :author, :title, :link, presence: true
end
