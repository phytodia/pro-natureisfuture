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
  end

  def update
  end

  def destroy
  end

  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial,:comment)
  end
end
