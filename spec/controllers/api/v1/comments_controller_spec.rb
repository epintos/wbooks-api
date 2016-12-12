require 'rails_helper'
describe Api::V1::CommentsController, type: :controller do
  include_context 'Authenticated User'
  let!(:book) { create(:book) }
  let!(:comment) { create(:comment, book: book, user: user) }

  describe 'GET #index' do
    context 'When fetching all the comments' do
      let!(:comments) { create_list(:comment, 5, book: book) }
      before do
        get :index, params: { book_id: book.id }
      end

      it 'responses with all the comments json' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          comments, each_serializer: CommentSerializer
        ).to_json
        expect(response_body.to_json) =~ JSON.parse(expected)
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'When fetching a book comment' do
      before do
        get :show, params: { book_id: book.id, id: comment.id }
      end

      it 'responses with the user comment json' do
        expect(response_body.to_json).to eq CommentSerializer.new(
          comment, root: false
        ).to_json
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'When creating a comment' do
      let(:new_comment_attributes) { attributes_with_foreign_keys(:comment, user: user) }
      it 'creates new comment' do
        expect do
          post :create, params: { book_id: book.id, comment: new_comment_attributes }
        end.to change { book.comments.count }.by(1)
      end

      it 'responds with 201 status' do
        post :create, params: { book_id: book.id, comment: new_comment_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'When creating an empty comment' do
      let!(:new_comment_attributes) do
        attributes_with_foreign_keys(:comment, user: user,
                                               content: nil)
      end

      it 'doesn\'t create a new comment' do
        expect do
          post :create, params: { book_id: book.id, comment: new_comment_attributes }
        end.to change { book.comments.count }.by(0)
      end

      it 'responds with 422 status' do
        post :create, params: { book_id: book.id, comment: new_comment_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'When deleting a comment' do
      it 'deletes a comment' do
        expect do
          delete :destroy, params: { book_id: book.id, id: comment.id }
        end.to change { book.comments.count }.by(-1)
      end

      it 'responds with 200 status' do
        delete :destroy, params: { book_id: book.id, id: comment.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PATCH #update' do
    context 'When modifying a comment' do
      let!(:modified_comment) { attributes_for(:comment) }
      it 'modifies a comment' do
        expect do
          patch :update, params: { book_id: book.id, id: comment.id, comment: modified_comment }
        end.to change { comment.reload.content }
      end

      it 'responds with 200 status' do
        patch :update, params: { book_id: book.id, id: comment.id, comment: modified_comment }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'When modifying with an empty comment' do
      let!(:modified_comment) { attributes_for(:comment, content: nil) }

      it 'doesn\'t update a new comment' do
        expect do
          patch :update, params: { book_id: book.id, id: comment.id,
                                   comment: modified_comment }
        end.to_not change { comment.reload.content }
      end

      it 'responds with 422 status' do
        patch :update, params: { book_id: book.id, id: comment.id,
                                 comment: modified_comment }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
