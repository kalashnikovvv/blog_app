class Articles::Searcher
  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def call
    scope = Article.includes(:user).ordered
    scope = scope.where(user_id: options[:user].id) if options[:user].present?
    scope = scope.visible if options[:only_visible]
    scope = scope.with_all_tags([options[:tag]]) if options[:tag].present?
    scope
  end
end
