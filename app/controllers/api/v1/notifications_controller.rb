module Api
  module V1
    class NotificationsController < ApplicationController
      before_action :authenticate_user!, :set_locale

      def index
        render json: policy_scope(Notification).where(filter_params).includes(:from)
      end

      def read_all
        policy_scope(Notification).unread.update_all(read: true)
        current_user.reset_unread_notifications
        head :no_content
      end

      def read
        policy_scope(Notification).unread.find(params[:id]).update(read: true)
        render json: {
          unread_notifications_count: current_user.unread_notifications_count,
          timestamp: Time.zone.now.to_formatted_s(:iso8601)
        }
      end

      def filter_params
        params.permit(:read, :reason)
      end
    end
  end
end
