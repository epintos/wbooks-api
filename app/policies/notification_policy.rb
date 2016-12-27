class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @scope.where(user_to: @user)
    end
  end
end
