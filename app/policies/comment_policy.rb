class CommentPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.current_user?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end
  def update?
    user.current_user? or not record.published?
  end
end
