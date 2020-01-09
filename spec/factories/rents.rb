FactoryBot.define do
  factory :rent do
    from { Faker::Time.between(from: Time.current - 10, to: Time.current) }
    to { from + Faker::Number.number(1).to_i.days }
    user
    book
  end
end
