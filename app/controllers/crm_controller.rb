class CrmController < ApplicationController
  layout "crm"
  before_action :authenticate_user!
  def index
    @prospects = Prospect.all
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
    redirect_to crm_index_path
  end

  def destroy
  end

  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial,:comment)
  end
end
