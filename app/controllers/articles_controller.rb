class ArticlesController < ApplicationController
  before_action :require_login, only: %i(new edit create update destroy)
  before_action :load_article, only: %i(show edit update destroy)
  before_action :load_user, only: %i(index)

  def index
    searcher_options = params.merge user: @user, only_visible: !current_user?(@user)
    @articles = Articles::Searcher.new(searcher_options).call.page(params[:page])
  end

  def show
    @comments = @article.comments.arrange(order: :created_at)
  end

  def new
    @article = current_user.articles.build
  end

  def edit
    authorize @article
  end

  def create
    @article = current_user.articles.build permitted_params
    if @article.save
      set_flash_message(:notice)
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    authorize @article
    if @article.update permitted_params
      set_flash_message(:notice)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    if @article.destroy
      set_flash_message(:notice)
    else
      set_flash_message(:alert)
    end
    redirect_to_back_or_default
  end

  private

  def load_article
    @article = Article.find(params[:id])
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def permitted_params
    params[:article].permit(:title, :text, :publish_date, :visible, :tags_string)
  end
end
