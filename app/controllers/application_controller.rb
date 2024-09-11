class ApplicationController < ActionController::Base
  #before_action :authenticate_user!

  around_action :switch_locale
  before_action :set_products_nav


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
    elsif params.has_key?("user")
      return admin_index_path
    elsif params.has_key?("commercial")
      return crm_path(current_commercial)
    end
  end

  def set_products_nav

    @preoccupations_visage = Product.where(gamme:'visage').pluck(:preoccupations).flatten.uniq.reject(&:empty?)
    @type_produits_visage = Product.where(gamme:'visage').pluck(:types_produit).flatten.uniq.reject(&:empty?)
    @preoccupations_corps = Product.where(gamme:'corps').pluck(:preoccupations).flatten.uniq.reject(&:empty?)
    @type_produits_corps = Product.where(gamme:'corps').pluck(:types_produit).flatten.uniq.reject(&:empty?)
    @pdts_nav_visage = Product.where(gamme:"visage").where(public:true)
    #@cremes = @pdts_nav_visage.where("'crème' = ANY (types_produit)")
    @pdts_nav_corps = Product.where(gamme:"corps").where(public:true)

    @soins_visage = Soin.all.where(category:"visage")
    @soins_corps = Soin.all.where(category:"corps")
    @soins_massages = Soin.all.where(category:"massage")
  end

end
