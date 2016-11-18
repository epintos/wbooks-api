FactoryGirl.define do
  factory :rent do
    from { Faker::Time.between(Time.current - 10, Time.current) }
    to { from + Faker::Number.number(1).to_i.days }
    user
    book
  end
end
