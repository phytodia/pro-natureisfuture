class SliderHomesController < ApplicationController
  def index
    @slider = SliderHome.first
  end

  def slider_params
    params.require(:slider_home).permit(slide_items_attributes:[:id,:link,:photo])
  end
end
