require 'rails_helper'

describe BookSuggestion, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:link) }

  subject(:book_suggestion) do
    BookSuggestion.new(
      title: title, author: author, link: link, editorial: editorial,
      price: price, publisher: publisher, year: year
    )
  end

  let(:title) { Faker::Book.title }
  let(:author) { Faker::Book.author }
  let(:publisher) { Faker::Book.publisher }
  let(:link) { Faker::Internet.url}
  let(:price) { Faker::Commerce.price }
  let(:editorial) { Faker::Company.name }
  let(:year) { Faker::Date.between(50.years.ago, 1.year.ago).year }

  it { is_expected.to be_valid }
end
