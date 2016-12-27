FactoryGirl.define do
  factory :notification do
    type { (0...2).to_a.sample }
    read false
    information Faker::Lorem.words(4)
    user_to factory: :user
    action factory: :book
  end
end
