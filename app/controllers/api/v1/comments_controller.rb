module Api
  module V1
    class CommentsController < ApplicationController
      def index
        render json: Comment.all.page(params[:page])
      end

      def show
        render json: comment
      end

      def create
        @comment = current_user.comments.build(comment_params)
        if comment.save
          head :created
        else
          render json: { error: comment.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize comment
        comment.destroy
        head :ok
      end

      def update
        authorize comment
        if comment.update(comment_params)
          head :ok
        else
          render json: { error: comment.errors }, status: :unprocessable_entity
        end
      end

      private

      def book
        @book ||= Book.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:user_id, :content).merge(book_id: book.id)
      end

      def comment
        @comment ||= Comment.find(params[:id])
      end
    end
  end
end
