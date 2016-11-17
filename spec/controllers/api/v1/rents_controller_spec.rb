require 'rails_helper'

describe Api::V1::RentsController, type: :controller do
  include_context 'Authenticated User'
  let!(:rent) { create(:rent, user: user) }

  describe 'GET #index' do
    context 'When fetching all the users rents' do
      before do
        get :index, params: { id: user.id }
      end

      it 'responses with the users rents json' do
        expect(response_body.to_json) =~ RentSerializer.new(rent, root: false).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
