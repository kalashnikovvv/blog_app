class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, presence: true, email: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }, format: /\w+/
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }, on: :create

  has_many :articles, dependent: :destroy
end
