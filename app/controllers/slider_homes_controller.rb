class SliderHomesController < ApplicationController
  def edit
    @slider = SliderHome.first
    slides = Slide.where(slider_home_id:@slider)
    @slider.slides = slides
  end

  def update
    @slider = SliderHome.first
    @slider.update(slider_params)
    redirect_to edit_slider_home_path(SliderHome.first)
  end

  def slider_params
    params.require(:slider_home).permit(photos: [])
  end
end
