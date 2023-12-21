class CrmController < ApplicationController
  layout "crm"
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

  def edit_prospect
    @prospect = Prospect.find(params[:id])
  end
  def update_prospect
    fail
    @prospect = Prospect.find(params[:id])
    @prospect.update(prospect_params)
    # No need for app/views/restaurants/update.html.erb
    fail
    #redirect_to prospect_path(@prospect)
  end

  def destroy
  end

  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial,:comment)
  end
end
