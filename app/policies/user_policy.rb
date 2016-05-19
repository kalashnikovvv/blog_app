class UserPolicy < BasePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    !user
  end

  def update?
    manage?
  end

  def destroy?
    manage?
  end

  private

  def manage?
    user && user.id == record.id
  end
end
