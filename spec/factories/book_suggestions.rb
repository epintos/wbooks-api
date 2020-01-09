FactoryBot.define do
  factory :book_suggestion do
    title { Faker::Book.title }
    author { Faker::Book.author }
    publisher { Faker::Book.publisher }
    link { Faker::Internet.url }
    price { Faker::Commerce.price }
    editorial { Faker::Company.name }
    year { Faker::Date.between(50.years.ago, 1.year.ago).year }
  end
end
