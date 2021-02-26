class ApplicationController < ActionController::Base
  include OrdersHelper
  include CartsHelper

  before_action :current_cart
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_ability
    # instead of Ability.new(current_user)
    @current_ability ||= ::Ability.new(current_account)
  end
  
  def default_url_options
    {locale: I18n.locale}
  end

  def current_cart
    session[:cart] ||= []
    @carts = session[:cart]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :address, :card_id, :phone_number])
  end

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end
end
