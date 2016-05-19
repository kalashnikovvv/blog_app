class CommentPolicy < BasePolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    user
  end

  def update?
    manage?
  end

  def destroy?
    manage?
  end

  private

  def manage?
    user && user.id == comment.user_id && 15.minutes.ago < comment.created_at
  end
end
