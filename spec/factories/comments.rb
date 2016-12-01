FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user
    book
  end
end
