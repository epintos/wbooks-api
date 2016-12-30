class NotificationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @scope.where(to: @user)
    end
  end
end
