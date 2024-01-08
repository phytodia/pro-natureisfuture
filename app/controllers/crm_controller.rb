class CrmController < ApplicationController
  layout "crm"
  #devise_group :crm, contains: [:user,:commercial]
  before_action :authenticate_commercial!
  #before_action :authenticate_crm!
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
    @prospects = Prospect.all.where(commercial_id: current_commercial.id)
  end

  def show_prospect
    @prospect = Prospect.find(params[:id])
  end

  def new_prospect
    @prospect = Prospect.new
  end

  def edit_prospect
    @prospect = Prospect.find(params[:id])
  end
  def update_prospect
    @prospect = Prospect.find(params[:id])
    @prospect.update(prospect_params)
    # No need for app/views/restaurants/update.html.erb
    redirect_to prospects_crm_index_path
  end

  def crm_customers
    @commercial = current_commercial
    @clients = Customer.all.where(commercial_id: @commercial.id)
  end

  def new_customer
    @prospect = Prospect.find(params[:prospect])
    @customer = Customer.new
  end

  def create_customer
    @customer = Customer.new(customer_params)
    Prospect.find(@customer.prospect_id).update!(statut:"client")
    if @customer.save
        redirect_to prospects_crm_index_path, notice: "Le prospect a été correctement transformé en client"
    else
      render :new
    end
  end

  def show_customer
    @customer =  Customer.find(params[:id])
    @instituts = @customer.instituts
  end

  def new_institut
    @institut = Institut.new
  end

  def create_institut
    @institut = Institut.new(institut_params)
    fail
    if @institut.save
      redirect_to customer_crm_index_path(@institut.customer_id), notice: "L'établissement a été correctement crée"
  else
    render :new
  end
  end


  def destroy
  end

  private
  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial_id,:comment)
  end

  def customer_params
    params.require(:customer).permit(:email, :password,:lastname,:firstname,:institut,:cp,:country,:town,:tel,:commercial_id,:prospect_id)
  end

  def institut_params
    params.require(:institut).permit(:name,:tel,:address,:cp,:city,:country,:latitude,:longitude,:customer_id,:horaires)
  end
end
