FactoryBot.define do
  factory :book do
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    genre { Faker::Book.genre }
    year { Faker::Date.between(from: 100.years.ago, to: Date.current).year }
    description { Faker::Lorem.paragraph }
  end
end
