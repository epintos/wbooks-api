require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:user_to_id) }

  subject(:notification) do
    build :notification
  end

  it { is_expected.to be_valid }

  describe '#update_counter_cache' do
    it 'updates the user unreaded_notifications_count' do
      notification.update_counter_cache
      expect(notification.user_to.unreaded_notifications_count)
        .to be(Notification.unreaded.where(user_to: notification.user_to).count)
    end
  end
end
