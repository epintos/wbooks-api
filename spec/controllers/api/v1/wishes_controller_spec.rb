require 'rails_helper'

describe Api::V1::WishesController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #index' do
    let!(:wishes) { create_list(:wish, 3, user: user) }
    context 'When fetching all users wishes' do
      before do
        get :index, params: { id: user.id }
      end

      it 'responses with alls users wishes json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          wishes, each_serializer: WishSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    let!(:wish) { create(:wish, user: user) }
    context 'When fetching a user\'s wish' do
      before do
        get :show, params: { user_id: user.id, id: wish.id }
      end

      it 'responses with the user\'s wishes json' do
        expect(response_body.to_json).to eq WishSerializer.new(
          wish, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create', type: :controller do
    context 'When creating a user\'s wish' do
      let(:new_wish) { build(:wish, user: user) }
      it 'creates a new wish' do
        expect do
          post :create, params: {
            id: user.id,
            wish: { book_id: new_wish.book.id, user_id: new_wish.user.id }
          }
        end.to change { Wish.count }.by(1)
      end

      it 'responds with 201 status' do
        post :create, params: {
          id: user.id,
          wish: { book_id: new_wish.book.id, user_id: new_wish.user.id }
        }
        expect(response).to have_http_status(:created)
      end
    end
  end
end
