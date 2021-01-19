class ApplicationController < ActionController::Base
  include SessionsHelper
  include OrdersHelper

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def require_admin
    return if current_account&.admin?

    flash[:danger] = t "error.permit"
    redirect_to root_path
  end

  def require_staff
    return if current_account&.staff?

    flash[:danger] = t "error.permit"
    redirect_to root_path
  end
end
