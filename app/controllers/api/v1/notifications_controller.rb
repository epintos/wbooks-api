module Api
  module V1
    class NotificationsController < ApplicationController
      def index
        render json: policy_scope(Notification).where(filter_params)
      end

      def read_all
        policy_scope(Notification).unreaded.update_all(read: true)
        current_user.update_unreaded_notifications_counter
        head :accepted
      end

      def read
        policy_scope(Notification).unreaded.find(params[:id]).update(read: true)
        current_user.update_unreaded_notifications_counter
        head :accepted
      end

      def filter_params
        params.permit(:read, :type)
      end
    end
  end
end
