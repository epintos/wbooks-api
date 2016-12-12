require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  include_context 'Authenticated User'
  let!(:user) { create(:user) }

  describe 'GET #show' do
    context 'When showing a user' do
      before do
        get :show, params: { id: user.id }
      end
      it 'responses with the user comment json' do
        expect(response_body.to_json).to eq UserSerializer.new(
          user, root: false
        ).to_json
      end
    end
  end

  describe 'PATCH #update' do
    context 'When modifying a user' do
      let!(:modified_user_attrs) { attributes_for(:user) }
      it 'modifies a user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end
      end

      it 'responds with 200 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When modifying a user with empty first name' do
      let!(:modified_user_attrs) { attributes_for(:user, first_name: nil) }
      it 'dosen\'t modifies the user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end.to_not change { user }
      end

      it 'responds with 422 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When modifying a user with empty last name' do
      let!(:modified_user_attrs) { attributes_for(:user, last_name: nil) }
      it 'dosen\'t modifies the user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end.to_not change { user }
      end

      it 'responds with 422 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When modifying a user with empty password' do
      let!(:modified_user_attrs) { attributes_for(:user, password: nil) }
      it 'dosen\'t modifies the user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end.to_not change { user }
      end

      it 'responds with 422 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When modifying a user with empty password confirmation' do
      let!(:modified_user_attrs) { attributes_for(:user, password_confirmation: nil) }
      it 'dosen\'t modifies the user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end.to_not change { user }
      end

      it 'responds with 422 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When modifying a user with empty email' do
      let!(:modified_user_attrs) { attributes_for(:user, email: nil) }
      it 'dosen\'t modifies the user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end.to_not change { user }
      end

      it 'responds with 422 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When modifying a user with empty locale' do
      let!(:modified_user_attrs) { attributes_for(:user, locale: nil) }
      it 'dosen\'t modifies the user' do
        expect do
          patch :update, params: { id: user.id, user: modified_user_attrs }
        end.to_not change { user }
      end

      it 'responds with 422 status' do
        patch :update, params: { id: user.id, user: modified_user_attrs }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST #create' do
    context 'When creating a user' do
      let(:new_user) { attributes_for(:user) }
      it 'creates new user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(1)
      end

      it 'responses with the access token' do
        post :create, params: { user: new_user }
        expect(response_body['access_token']).to be_present
      end

      it 'responses with the renew id' do
        post :create, params: { user: new_user }
        expect(response_body['renew_id']).to be_present
      end

      it 'responds with 201 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:created)
      end
    end

    context 'When creating a user with empty first name' do
      let(:new_user) { attributes_for(:user, first_name: nil) }
      it 'dosen\'t creates the user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When creating a user with empty last name' do
      let(:new_user) { attributes_for(:user, last_name: nil) }
      it 'dosen\'t creates the user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When creating a user with empty password' do
      let(:new_user) { attributes_for(:user, password: nil) }
      it 'dosen\'t creates the user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When creating a user with empty password confirmation' do
      let(:new_user) { attributes_for(:user, password_confirmation: nil) }
      it 'dosen\'t creates the user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When creating a user with empty email' do
      let(:new_user) { attributes_for(:user, email: nil) }
      it 'dosen\'t creates the user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'When creating a user with empty locale' do
      let(:new_user) { attributes_for(:user, locale: nil) }
      it 'dosen\'t creates the user' do
        expect do
          post :create, params: { user: new_user }
        end.to change { User.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { user: new_user }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
