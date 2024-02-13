class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(resource)
    if params.has_key?("customer")
      return espace_pro_path(current_customer)
    else
    end
  end

end
