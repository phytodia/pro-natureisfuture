class CrmController < ApplicationController
  layout "crm"
  before_action :authenticate_commercial!
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def crm_prospects
    if current_commercial.email == "ev@phytodia.com"
      @prospects = Prospect.all.where(commercial:"Emilie Vanhoutte")
    elsif current_commercial.email == "mt@phytodia.com"
      @prospects = Prospect.all.where(commercial:"Marine Toussaint")
    else
      @prospects = Prospect.all
    end
  end

  def show_prospect
    @prospect = Prospect.find(params[:id])
  end

  def edit_prospect
    @prospect = Prospect.find(params[:id])
  end
  def update_prospect
    @prospect = Prospect.find(params[:id])
    @prospect.update(prospect_params)
    # No need for app/views/restaurants/update.html.erb
    redirect_to prospects_crm_path
  end

  def new_customer
    @prospect = Prospect.find(params[:prospect])
    @customer = Customer.new
  end

  def create_customer
    @customer = Customer.new(customer_params)
    Prospect.find(@customer.prospect_id).update!(statut:"client")
    if @customer.save
        redirect_to prospects_crm_path, notice: "Le prospect a été correctement transformé en client"
    else
      render :new
    end
  end

  def destroy
  end

  private
  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial,:comment)
  end

  def customer_params
    params.require(:customer).permit(:email, :password,:lastname,:firstname,:institut,:cp,:country,:town,:tel,:commercial_id,:prospect_id)
  end
end
