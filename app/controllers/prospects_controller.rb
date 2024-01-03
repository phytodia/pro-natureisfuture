class ProspectsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @prospect = Prospect.new
  end

  def create
    @prospect = Prospect.new(prospect_params)
    @prospect.save
    if @prospect.save
      redirect_to prospects_path
    else
      render :new
    end
  end

  def edit
    @prospect = Prospect.find(params[:id])
  end

  def update
    @prospect = Prospect.find(params[:id])
    @prospect.update(prospect_params)
    # No need for app/views/restaurants/update.html.erb
    redirect_to prospect_path(@prospect)
  end

  def destroy
    @prospect = Prospect.find(params[:id])
    @prospect.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to root_path
  end

  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial_id,:comment)
  end
end
