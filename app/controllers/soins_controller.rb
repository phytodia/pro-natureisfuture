class SoinsController < ApplicationController
  add_breadcrumb "Home".upcase, :root_path
  before_action :authenticate_user!, only:[:new,:create,:edit,:update,:destroy]
  def index
    add_breadcrumb "<strong>Soins</strong>".upcase.html_safe, soins_path
    @soins = Soin.all
    @products = Soin.all
    @cover =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["visage"]["cover"]
    @intro =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["visage"]["texte"]
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
    #@soin = Soin.find(params[:id])
    @soin = Soin.friendly.find(params[:id])
    add_breadcrumb "Soins".upcase.html_safe, soins_path
    if @soin.category == "visage"
      add_breadcrumb "<strong>#{@soin.category.upcase}</strong>".html_safe, visage_soins_path
    elsif @soin.category == "corps"
      add_breadcrumb "<strong>#{@soin.category.upcase}</strong>".html_safe, corps_soins_path
    end
    @page_title = "#{@soin.name} | Nature is Future Pro"
    @page_description = "Member login page."

    @labels = {
      "ECOCERT": "ecocert-organic.png",
      "Qualité Nature is Future": "charte-qualite.png",
      "FABRIQUÉ EN FRANCE": "fabrique-en-france.png",
      "NATUREL": "naturel.png",
      "PHYTOTHÉRAPIE INNOVANTE": "phytotherapie-innovante-responsable.png"
    }
  end

  def edit
    @soin = Soin.friendly.find(params[:id])
  end

  def update
    @soin = Soin.friendly.find(params[:id])
    @soin.update(soin_params)
    @soin.products = []
    params[:soin][:product_ids] = params[:soin][:product_ids].reject(&:blank?)
    params[:soin][:product_ids].each do |pdt_id|
      @soin.products << Product.find(pdt_id)
    end
    @soin.save
    redirect_to soin_path(@soin)
  end

  def visage
    add_breadcrumb "Soins".upcase.html_safe, soins_path
    add_breadcrumb "<strong>visage</strong>".upcase.html_safe, visage_soins_path
    #add_breadcrumb "<strong>#{@product.name.upcase}</strong>".html_safe, product_path
    @soins = Soin.all.where(category: "visage")
    @products = Soin.all.where(category: "visage")
    @cover =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["visage"]["cover"]
    @intro =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["visage"]["texte"]
  end

  def corps
    add_breadcrumb "Soins".upcase.html_safe, soins_path
    add_breadcrumb "<strong>corps</strong>".upcase.html_safe, visage_soins_path
    @soins = Soin.all.where(category: "corps")
    @products = Soin.all.where(category: "corps")
    @cover =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["corps"]["cover"]
    @intro =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["corps"]["texte"]
  end

  def massages
    add_breadcrumb "Soins".upcase.html_safe, soins_path
    add_breadcrumb "<strong>massages</strong>".upcase.html_safe, visage_soins_path
    @soins = Soin.all.where(category: "massage")
    @products = Soin.all.where(category: "massage")
    @cover =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["soins"]["cover"]
    @intro =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")["soins"]["texte"]
  end

  def filter
    @products = Soin.all.where(category: "visage")
    respond_to do |format|
      format.html { redirect_to soins_path(products: @products) }
      format.json
    end
  end

  def cat_bis
    @labels = {
      "ECOCERT": "ecocert-organic.png",
      "Qualité Nature is Future": "charte-qualite.png",
      "FABRIQUÉ EN FRANCE": "fabrique-en-france.png",
      "NATUREL": "naturel.png",
      "PHYTOTHÉRAPIE INNOVANTE": "phytotherapie-innovante-responsable.png"
    }
  end

  private
  def soin_params
    params.require(:soin).permit(:name,:description,:category,:price_ttc,:pregnant_adapted,:estimated_time,:photo,:resultat,:cible,:protocole,actions_product:[],labels:[],types_peau:[],benefices:[])
  end
end
