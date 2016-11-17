require 'rails_helper'

describe Api::V1::RentsController, type: :controller do
  include_context 'Authenticated User'
  let!(:rents) { create_list(:rent, 3, user: user) }

  describe 'GET #index' do
    context 'When fetching all the users rents' do
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
end
