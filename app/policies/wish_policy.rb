class WishPolicy < ApplicationPolicy
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

  attr_reader :user, :wish

  def initialize(user, wish)
    @user = user
    @wish = wish
  end

  def show?
    @wish.user == @user
  end

  def create?
    @wish.user_id == @user.id
  end
end
