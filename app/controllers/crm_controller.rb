class CrmController < ApplicationController
  layout "crm"
  before_action :authenticate_user!
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
    if current_user.email == "ev@phytodia.com"
      @prospects = Prospect.all.where(commercial:"Emilie Vanhoutte")
    elsif current_user.email == "mt@phytodia.com"
      @prospects = Prospect.all.where(commercial:"Marine Toussaint")
    else
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

  def destroy
  end

  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial,:comment)
  end
end
