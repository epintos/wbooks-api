require 'rails_helper'

describe BookSuggestion, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:link) }

  subjet(:book_suggestion) do
    BookSuggestion.new(
      title: title, author: author, link: link, editorial: editorial,
      price: price, publisher: publisher, year: year.
    )
  end

  let(:title) { Fake::Book.title }
  let(:author) { Fake::Book.author }
  let(:publisher) { Fake::Book.publisher }
  let(:link) { Fake::Internet.url}
  let(:price) { Faker::Commerce.price }
  let(:editorial) { Faker::Company.name }

  it { is_expected.to be_valid }
  end    
end
