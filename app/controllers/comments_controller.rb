class CommentsController < ApplicationController
  before_action :require_login, expect: %i(index)
  before_action :load_article, only: %i(new edit create update destroy)
  before_action :load_comment, only: %i(edit update destroy)

  def new
    authorize :comment
    @comment = Comment.new
    render layout: false
  end

  def edit
    authorize @comment
    render layout: false
  end

  def create
    authorize @comment
    @comment = @article.comments.build permitted_params
    @comment.user = current_user
    if @comment.save
      render partial: "articles/comments/item", locals: { comment: @comment }
    else
      render :new, layout: false, status: :unprocessable_entity
    end
  end

  def update
    authorize @comment
    if @comment.update permitted_params
      render partial: "articles/comments/item", locals: { comment: @comment }
    else
      render :edit, layout: false, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    render nothing: true
  end

  private

  def load_article
    @article = Article.find(params[:article_id])
  end

  def load_comment
    @comment = @article.comments.find(params[:id])
  end

  def permitted_params
    params[:comment].permit(:text, :parent_id)
  end
end
