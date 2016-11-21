class RentPolicy < ApplicationPolicy
  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  def show?
    @rent.user.id == @user.id
  end

  def create?
    @rent.user_id == @user.id
  end
end
