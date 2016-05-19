class Comment < ActiveRecord::Base
  has_ancestry

  belongs_to :user
  belongs_to :article
  belongs_to :parent, class_name: "Comment"
  has_many :comments

  validates :text, presence: true
end
