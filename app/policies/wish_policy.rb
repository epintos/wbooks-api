class WishPolicy < ApplicationPolicy
  attr_reader :user, :wish

  def initialize(user, wish)
    @user = user
    @wish = wish
  end

  def show?
    @wish.user.id == @user.id
  end

  def create?
    @wish.user_id == @user.id
  end
end
