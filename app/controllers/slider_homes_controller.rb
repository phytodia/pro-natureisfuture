class SliderHomesController < ApplicationController
  def index
    @slider = SliderHome.first
  end
  def edit
    @slider = SliderHome.first
    @slide = SlideItem.find(params[:id])
    #slides = SlideItem.where(slider_home_id:@slider)
  end

  def update
    @slide = SlideItem.find(params[:id])
    @slide.update(slider_params)
    redirect_to edit_slider_home_path(SliderHome.first)
  end

  def slider_params
    params.require(:slider_home).permit(slide_items_attributes:[:id,:link,:photo])
  end
end
