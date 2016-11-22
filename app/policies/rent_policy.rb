class RentPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      @scope.where(user: @user)
    end
  end

  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  def show?
    @rent.user == @user
  end

  def create?
    @rent.user_id == @user.id
  end

  def destroy?
    @rent.user == @user
  end
end
