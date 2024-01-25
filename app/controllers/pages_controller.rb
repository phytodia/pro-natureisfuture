class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home
  def home
  end
  def contact
  end

  def category
    category = params[:category]
    @products = Product.all.where(gamme:category)
  end
  def filtres

  end
end
