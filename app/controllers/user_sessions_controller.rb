class UserSessionsController < ApplicationController
  before_action :require_login, only: %i(destroy)

  def new
    @user_session_form = UserSessionForm.new
  end

  def create
    @user_session_form = UserSessionForm.new(permitted_params)
    user = login(@user_session_form.email, @user_session_form.password)

    if user
      set_flash_message(:notice)
      redirect_to root_path
    else
      @user_session_form.password = nil
      render :new
    end
  end

  def destroy
    logout
    byebug
    set_flash_message(:notice)
    redirect_to root_path
  end

  private

  def permitted_params
    params[:user_session_form].permit(:email, :password)
  end
end
