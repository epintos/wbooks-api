FactoryBot.define do
  factory :rent do
    from { Faker::Time.between(from: Time.current - 10, to: Time.current).to_date }
    to { from + Faker::Number.number(digits: 1).to_i.days }
    user
    book
  end
end
