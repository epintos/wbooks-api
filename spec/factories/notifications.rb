FactoryGirl.define do
  factory :notification do
    reason { Notification.reasons.keys.sample }
    read false
    information { Faker::Lorem.words(4) }
    to factory: :user
    action factory: :book
  end
end
