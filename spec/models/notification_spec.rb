require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create :user }

  it { should validate_presence_of(:reason) }
  it { should validate_presence_of(:to_id) }
  it { should validate_presence_of(:action_type) }
  it { should validate_presence_of(:action_id) }

  subject(:notification) do
    Notification.new(
      reason: reason,
      read: read,
      information: information,
      to: to,
      action: action
    )
  end

  let!(:reason) { Notification.reasons.keys.sample }
  let!(:read) { Faker::Boolean.boolean }
  let!(:information) { Faker::Lorem.words(4) }
  let!(:to) { create(:user) }
  let!(:action) { create(:book) }

  it { is_expected.to be_valid }

  describe '#user_reset_notifications_counter' do
    context 'When a notification try to update unread_notifications_counter' do
      it 'updates the user unread_notifications_count' do
        notification.user_reset_unread_notifications
        expect(notification.to.unread_notifications_count)
          .to be(Notification.unread.where(to: notification.to).count)
      end
    end
  end

  describe '#destroy' do
    let!(:notifications) { create_list(:notification, 5, to: user, read: false) }
    context 'When a notification is destroyed' do
      it 'updates the corresponding user unread_notifications_count' do
        expect do
          user.notifications.unread.sample.destroy
        end.to change { user.reload.unread_notifications_count }.by(-1)
      end
    end
  end

  describe '#create' do
    context 'When a notification is created' do
      it 'updates the corresponding user unread_notifications_count' do
        expect do
          create(:notification, to: user)
        end.to change { user.reload.unread_notifications_count }.by(1)
      end
    end
  end
end
