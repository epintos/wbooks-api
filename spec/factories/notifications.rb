FactoryBot.define do
  factory :notification do
    reason { Notification.reasons.keys.sample }
    read { false }
    to factory: :user
    from factory: :user
    action factory: :book
  end
end
