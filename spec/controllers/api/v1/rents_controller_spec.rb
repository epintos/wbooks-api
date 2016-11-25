require 'rails_helper'

describe Api::V1::RentsController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the users rents' do
      let!(:rents) { create_list(:rent, 3, user: user) }
      before do
        get :index, params: { id: user.id }
      end

      it 'responses with the users rents json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          rents, each_serializer: RentSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When fetching a user rent' do
      let!(:rent) { create(:rent, user: user) }
      before do
        get :show, params: { user_id: user.id, id: rent.id }
      end

      it 'responses with the user rent json' do
        expect(response_body.to_json).to eq RentSerializer.new(
          rent, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'When creating a valid user rent' do
      let!(:new_rent_attributes) { attributes_with_foreign_keys(:rent, user: user) }
      it 'creates a new rent' do
        expect do
          post :create, params: { id: user.id, rent: new_rent_attributes }
        end.to change { Rent.count }.by(1)
      end

      it 'responds with 201 status' do
        post :create, params: { id: user.id, rent: new_rent_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'When creating an invalid user rent' do
      let!(:new_rent_attributes) do
        attributes_with_foreign_keys(:rent, book: nil, user: user)
      end
      before do
        post :create, params: { id: user.id, rent: new_rent_attributes }
      end

      it 'doesn\'t create a new rent' do
        expect do
          post :create, params: { id: user.id, rent: new_rent_attributes }
        end.to change { Rent.count }.by(0)
      end

      it 'returns error messages' do
        expect(response_body['error']).to be_present
      end

      it 'responds with 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
