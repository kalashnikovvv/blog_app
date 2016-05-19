class UsersController < ApplicationController
  before_action :require_login, only: %i(update destroy)
  before_action :load_user, only: %i(edit update destroy)

  def new
    authorize @user
    build_user
  end

  def edit
    authorize @user
  end

  def create
    authorize @user
    build_user(permitted_params)
    password = @user.password
    if @user.save
      login @user.email, password
      set_flash_message(:notice)
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    authorize @user

    if @user.update(permitted_params)
      set_flash_message(:notice)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def build_user(attributes = {})
    @user = User.new attributes
  end

  def permitted_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end
end
