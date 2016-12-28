require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create :user }

  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:user_to_id) }
  it { should validate_presence_of(:action_type) }

  subject(:notification) do
    build :notification
  end

  it { is_expected.to be_valid }

  describe '#user_update_notifications_counter' do
    it 'updates the user unreaded_notifications_count' do
      notification.user_update_notifications_counter
      expect(notification.user_to.unreaded_notifications_count)
        .to be(Notification.unreaded.where(user_to: notification.user_to).count)
    end
  end

  describe 'delete notifications' do
    it 'updates the corresponding user unreaded_notifications_count' do
      create_list(:notification, 5, user_to: user)
      user.notifications.destroy_all
      expect(user.reload.unreaded_notifications_count).to be(0)
    end
  end
end
