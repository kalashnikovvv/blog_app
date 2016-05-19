class ArticlePolicy < BasePolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
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
    user && user.id == article.user_id
  end
end
