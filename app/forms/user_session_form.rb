class UserSessionForm
  include ActiveModel::Model

  attr_accessor :email, :password

  def persisted?
    false
  end
end
