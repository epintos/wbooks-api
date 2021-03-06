require 'rails_helper'

describe Api::V1::RentsController, type: :controller do
  include_context 'Authenticated User'

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

  describe 'PUT #update' do
    context 'When updating a rent\'s return date'
    let(:rent) { create(:rent, user: user) }
    it 'updates the rent\'s return date' do
      expect do
        put :update, params: { user_id: user.id, id: rent.id }
      end.to change { rent.reload.returned_at }.to(Time.zone.today)
    end
  end

  describe 'POST #create' do
    let(:book) { create(:book) }
    context 'When creating a valid user rent' do
      let!(:new_rent_attributes) { attributes_with_foreign_keys(:rent, user: user, book: book) }
      it 'creates a new rent' do
        expect do
          post :create, params: { user_id: user.id, rent: new_rent_attributes }
        end.to change { Rent.count }.by(1)
      end

      it 'increments the rents historic counter' do
        expect do
          post :create, params: { user_id: user.id, rent: new_rent_attributes }
        end.to change { user.reload.rents_counter }.by(1)
      end

      it 'responds with 201 status' do
        post :create, params: { user_id: user.id, rent: new_rent_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'When creating an invalid user rent' do
      let!(:new_rent_attributes) do
        attributes_with_foreign_keys(:rent, book: nil, user: user)
      end
      before do
        post :create, params: { user_id: user.id, rent: new_rent_attributes }
      end

      it 'doesn\'t create a new rent' do
        expect do
          post :create, params: { user_id: user.id, rent: new_rent_attributes }
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
