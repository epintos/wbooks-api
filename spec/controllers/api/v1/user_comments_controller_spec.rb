require 'rails_helper'
describe Api::V1::UserCommentsController, type: :controller do
  include_context 'Authenticated User'
  describe 'GET #index' do
    context 'When fetching all the user comments' do
      let!(:comments) { create_list(:comment, 5, user: user) }
      before do
        get :index, params: { user_id: user.id }
      end

      it 'responses with all the user comments json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          user.comments, each_serializer: CommentSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
