FactoryBot.define do
  factory :book_suggestion do
    user
    title { Faker::Book.title }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
    link { Faker::Internet.url }
    price { Faker::Commerce.price }
    editorial { Faker::Company.name }
    year { Faker::Date.between(from: 50.years.ago, to: 1.year.ago).year }
  end
end
