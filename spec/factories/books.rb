FactoryGirl.define do
  factory :book do
    author { Faker::Book.author }
    title { Faker::Book.title }
    publisher { Faker::Book.publisher }
    genre { Faker::Book.genre }
    year { Faker::Date.between(100.years.ago, Date.current).year }
  end
end
