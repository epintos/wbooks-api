require 'rails_helper'
describe Api::V1::NotificationsController, type: :controller do
  include_context 'Authenticated User'
  let!(:user_to) { create(:user) }
  let!(:notification) { create(:notification, user_to: user, read: false) }

  describe 'GET #index' do
    context 'When fetching all the notifications' do
      let!(:notifications) { create_list(:notification, 5, user_to: user) }
      before do
        get :index, params: { user_id: user.id }
      end

      it 'responses with all the notifications json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          notifications, each_serializer: NotificationSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT #read' do
    context 'When marking as read a notification' do
      it 'mark as read' do
        expect do
          put :read, params: { user_id: notification.user_to.id, id: notification.id }
        end.to change { notification.reload.read }.to(true)
      end

      it 'updates unreaded_notifications_counter to user' do
        notification = create(:notification, user_to: user, read: false)
        expect do
          put :read, params: { user_id: notification.user_to.id, id: notification.id }
        end.to change { user.reload.unreaded_notifications_count }.by(-1)
      end

      it 'responds with 200 status' do
        put :read, params: { user_id: user.id, id: notification.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT #read_all' do
    let!(:notifications) { create_list(:notification, 5, user_to: user) }
    let!(:notification) { create(:notification, user_to: user) }
    context 'When marking as read a notification' do
      it 'marks as readed every notification' do
        put :read_all, params: { user_id: user.id }
        expect(user.notifications.unreaded.count).to be(0)
      end

      it 'updates unreaded_notifications_counter to user' do
        expect do
          put :read_all, params: { user_id: notification.user_to.id }
        end.to change { user.reload.unreaded_notifications_count }.to(0)
      end

      it 'responds with 204 status' do
        put :read_all, params: { user_id: user.id, id: notification.id }
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
