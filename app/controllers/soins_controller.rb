class SoinsController < ApplicationController
  def index
    @soins = Soin.all
  end

  def show
    @soin = Soin.find(params[:id])
  end

  def visage
    @soins = Soin.all.where(category: "visage")
  end

  def corps
    @soins = Soin.all.where(category: "corps")
  end

  def massages
    @soins = Soin.all.where(category: "massage")
  end

  private
  def soin_params
    params.require(:soin).permit(:name,:description,:category,:estimated_time,:photo)
  end
end
