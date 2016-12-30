class RentPolicy < ApplicationPolicy
  def show
    record.user == user
  end

  def create?
    record.user_id == user.id
  end

  def destroy
    record.user == user
  end
end
