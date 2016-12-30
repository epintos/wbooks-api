require 'rails_helper'

describe Api::V1::BookRentsController, type: :controller do
  include_context 'Authenticated User'

  describe 'GET #index' do
    context 'When fetching all the book rents' do
      let!(:book) { create(:book) }
      let!(:rents) { create_list(:rent, 3, user: user, book: book) }
      before do
        get :index, params: { book_id: book.id }
      end

      it 'responses with the book rents json' do
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
