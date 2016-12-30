require 'rails_helper'
describe Api::V1::NotificationsController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the notifications with search reason parameters' do
      let!(:reason) { Notification.reasons.keys.sample }
      let!(:notifications) do
        create_list(:notification, 5, to: user, reason: Notification.reasons.keys.sample)
      end

      before do
        get :index, params: { user_id: user.id, reason: reason }
      end

      it 'responses with the same quantity of notifications than notifications filtered' do
        expect(response_body.count).to eq(user.notifications.where(reason: reason).count)
      end

      it 'responses with the notifications filtered by reason param in json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          user.notifications.where(reason: reason), each_serializer: NotificationSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching all the notifications with search read parameters' do
      let!(:read) { Faker::Boolean.boolean }
      let!(:notifications) do
        create_list(:notification, 5, to: user, read: -> { Faker::Boolean.boolean })
      end

      before do
        get :index, params: { user_id: user.id, read: read }
      end

      it 'responses with the same quantity of notifications than notifications filtered' do
        expect(response_body.count).to eq(user.notifications.where(read: read).count)
      end

      it 'responses with the notifications filtered by read param in json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          user.notifications.where(read: read), each_serializer: NotificationSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When fetching all the notifications without search parameters' do
      let!(:notifications) { create_list(:notification, 5, to: user) }
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
    context 'When marking as read a notification from other user' do
      let!(:other_user) { create(:user) }
      let!(:notification) { create(:notification, to: other_user) }

      it 'doesn\'t mark as read' do
        expect do
          put :read, params: { user_id: notification.to.id, id: notification.id }
        end.to_not change { notification.reload.read }
      end

      it 'responds with 400 status' do
        put :read, params: { user_id: user.id, id: notification.id }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'When marking as read a notification from current user' do
      let!(:notification) { create(:notification, to: user) }
      it 'mark as read' do
        expect do
          put :read, params: { user_id: notification.to.id, id: notification.id }
        end.to change { notification.reload.read }.to(true)
      end

      it 'updates unreaded_notifications_counter to user' do
        expect do
          put :read, params: { user_id: notification.to.id, id: notification.id }
        end.to change { user.reload.unread_notifications_count }.by(-1)
      end

      it 'responds with 200 status' do
        put :read, params: { user_id: user.id, id: notification.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #read_all' do
    let!(:notifications) { create_list(:notification, 5, to: user) }
    let!(:notification) { create(:notification, to: user) }
    context 'When marking as read a notification' do
      it 'marks as readed every notification' do
        post :read_all, params: { user_id: user.id }
        expect(user.notifications.unread.count).to be(0)
      end

      it 'updates unread_notifications_counter to user' do
        post :read_all, params: { user_id: user.id, test: true }
        expect(user.reload.unread_notifications_count).to be(0)
      end

      it 'responds with 204 status' do
        post :read_all, params: { user_id: user.id }
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
