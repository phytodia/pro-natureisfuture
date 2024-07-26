class SliderHomesController < ApplicationController
  def edit
    @slider = SliderHome.first
    #slides = SlideItem.where(slider_home_id:@slider)
    @slides = @slider.slide_items
  end

  def update
    @slider = SliderHome.first
    @slider.update(slider_params)
    redirect_to edit_slider_home_path(SliderHome.first)
  end

  def slider_params
    params.require(:slider_home).permit(slide_items_attributes:[:id,:link,:photo])
  end
end
