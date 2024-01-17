class EspaceProController < ApplicationController
  before_action :authenticate_customer!, except:[:index]

  def index
    if !current_customer.nil?
      redirect_to espace_pro_path(current_customer)
    end
  end

  def show

  end

  def etablissements
    @instituts = Institut.all.where(customer_id: current_customer.id)
  end

  def etablissements_show
    @institut = Institut.find(params[:id])
    @current_customer = current_customer
    if @institut.customer != @current_customer
      redirect_to espace_pro_path(current_customer)
    end
    fail
  end

  def produits

  end

  def cours
  end
  def faq

  end
  def phototheque

  end

  private
  def check_profile
    @profile = Profile.find(current_customer.profile.id)
    #redirect_to espace_pro_index_path
  end

end
