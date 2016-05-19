class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :current_user?

  private

  def user_not_authorized
    message = I18n.t("messages.failures.user_not_authorized")
    respond_to do |f|
      f.html { flash.alert = message; redirect_to_back_or_default }
      f.js { render js: "toastr.error('#{message}')", status: :forbidden }
      f.json { render json: { message: message }, status: :forbidden }
    end
  end

  def user_not_authenticated
    message = I18n.t("messages.failures.user_not_authenticated")
    respond_to do |f|
      f.html { flash.alert = message; redirect_to login_path }
      f.js { render js: "toastr.error('#{message}')", status: :unauthorized }
      f.json { render json: { message: message }, status: :unauthorized }
    end
  end

  def redirect_to_back_or_default(default = root_path)
    if request.env["HTTP_REFERER"].present? && request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  def set_flash_message(message_type, options = {})
    flash[message_type] = message(message_type, options)
  end

  def message(message_type, options = {})
    controller_key = controller_path.tr("/", ".")
    key = "messages.#{controller_key}.#{action_name}.#{message_type}"
    message_or_message_hash = I18n.t(key, options[:i18n_options] || {})
    message = if message_or_message_hash.is_a?(Hash)
      message_or_message_hash[options[:type].to_s]
    else
      message_or_message_hash
    end
  end

  def current_user?(user)
    current_user && current_user.try(:id) == user.try(:id)
  end
end
