class HomeController < ApplicationController
  def index
    @articles = Articles::Searcher.new(params).call.page(params[:page])
  end
end
