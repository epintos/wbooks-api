module Api
  module V1
    class CommentsController < ApplicationController
      def index
        render json: book.comments.includes(:user).page(params[:page])
      end

      def show
        render json: comment
      end

      # TODO: Refactor and remove rubocop exception
      # rubocop:disable Metrics/AbcSize
      def create
        @comment = current_user.comments.build(comment_params)
        comment.user.increment(:comments_counter)
        if comment.save && comment.user.save
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
        @book ||= Book.find(params[:book_id])
      end

      def comment_params
        params.require(:comment).permit(:user_id, :content).merge(book_id: book.id)
      end

      def comment
        @comment ||= book.comments.find(params[:id])
      end
    end
  end
end
