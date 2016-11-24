class RentPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      @scope.where(user: @user)
    end
  end

  def create?
    record.user == user
  end
end
