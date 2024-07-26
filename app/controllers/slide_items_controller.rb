class SlideItemsController < ApplicationController
  def new
  end

  def create
  end

  def edit
    @slider = SliderHome.first
    @slide = SlideItem.find(params[:id])
  end

  def update
    @slide = SlideItem.find(params[:id])
    @slide.update(slide_params)
    redirect_to slider_homes_path()
  end

  def destroy
  end

  def slide_params
    params.require(:slide_item).permit(:id,:photo,:link)
  end
end
