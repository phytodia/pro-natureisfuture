class SlideItemsController < ApplicationController
  def new
    @slider = SliderHome.first
    @slide = SlideItem.new
  end

  def create
    @slider = SliderHome.first
    @slide = SlideItem.new(slide_params)
    @slide.slider_home = @slider
    @slide.save
    redirect_to slider_homes_path()
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
