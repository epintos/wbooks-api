module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        render json: policy_scope(Notification).where(filter_params).includes(:user_from)
      end

      def read_all
        policy_scope(Notification).unreaded.update_all(read: true)
        current_user.update_notifications_counter
        head :no_content
      end

      def read
        policy_scope(Notification).unreaded.find(params[:id]).update(read: true)
        current_user.update_notifications_counter
        render json: {
          unreaded_notifications_count: current_user.unreaded_notifications_count,
          timestamp: Time.zone.now.to_formatted_s(:iso8601)
        }
      end

      def filter_params
        params.permit(:read, :type)
      end
    end
  end
end
