class Article < ActiveRecord::Base
  paginates_per 5
  acts_as_taggable_array_on :tags

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  validates :publish_date, presence: true

  after_initialize :set_defaults

  scope :ordered, -> { order(publish_date: :desc) }
  scope :visible, -> { where(visible: true) }

  def tags_string=(value)
    self.tags = value.split(" ").uniq
  end

  def tags_string
    tags.join(" ")
  end

  private

  def set_defaults
    self.visible = true if visible.nil?
  end
end
