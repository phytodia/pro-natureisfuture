class SoinsController < ApplicationController
  def index
    @soins = Soin.all
  end

  def new
    @soin = Soin.new
  end
  def create
    @soin = Soin.new(soin_params)
    params[:soin][:product_ids] = params[:soin][:product_ids].reject(&:blank?)
    params[:soin][:product_ids].each do |pdt_id|
      @soin.products << Product.find(pdt_id)
    end
    if @soin.save
      redirect_to soins_path
    else
      rendre :new
    end
  end

  def show
    @soin = Soin.find(params[:id])
  end

  def visage
    @soins = Soin.all.where(category: "visage")
    @products = Soin.all.where(category: "visage")
    @cover =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["visage"]["cover"]
    @intro =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["visage"]["texte"]
  end

  def corps
    @soins = Soin.all.where(category: "corps")
  end

  def massages
    @soins = Soin.all.where(category: "massage")
  end

  def filter

  end

  private
  def soin_params
    params.require(:soin).permit(:name,:description,:category,:price_ttc,:estimated_time,:photo)
  end
end
