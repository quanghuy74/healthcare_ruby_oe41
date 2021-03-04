require_relative "boot"
require "rails/all"
require "active_model_serializers"
require "jwt"
Bundler.require(*Rails.groups)
module HealthcareRubyOe41
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
  end
end
