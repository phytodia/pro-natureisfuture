class ProductsController < ApplicationController
  add_breadcrumb "Home".upcase, :root_path
  before_action :authenticate_user!, only:[:new,:create,:edit,:update,:destroy]
  def index
    @products = Product.all.where(public:true)
  end

  def show
    #@product = Product.find(params[:id])
    @product = Product.friendly.find(params[:id]) if Product.friendly.find(params[:id]).public == true
    add_breadcrumb "Cosmétiques".upcase.html_safe, products_path
    add_breadcrumb "<strong>#{@product.name.upcase}</strong>".html_safe, product_path

    @page_title = "#{@product.name} | Cosmétique bio pour professionnels | Nature is Future Pro"
    @page_description = ""

    @actifs_collection = YAML.load_file("#{Rails.root.to_s}/db/yaml/actifs.yml")
    @photos = @product.photos
    hash_actifs = {}
    array_actifs = []
    @product.product_actifs.each do |actif|
      actif_hash = {name:actif,description: @actifs_collection[actif]["description"],photo:@actifs_collection[actif]["visuel"],lien:@actifs_collection[actif]["link"]}
      #hash_actifs.store(actif,actif_hash)
      array_actifs.push(hash_actifs.store(actif,actif_hash))
      #caroussel_elements.merge(actif)
      #fail
    end
    @caroussel_actifs = array_actifs
    ### Soins associés pour le caroussel
    soins_associes = []
    hash_soins = {}
    @product.soins.each do |soin|
      soin_hash = {name: soin.name, description:soin.description, photo:soin.photo,lien:soin.slug}
      soins_associes.push(hash_soins.store(soin.name,soin_hash))
    end
    @soins_associes = soins_associes
    ### Produits complémentaires pour le caroussel
    produits_complementaires = []
    hash_products = {}
    @product.products_complementaires.each do |pdt|
      products_hash = {name: Product.find(pdt).name, description: Product.find(pdt).description,photo:Product.find(pdt).photos[0],lien:Product.find(pdt).slug}
      produits_complementaires.push(hash_products.store(Product.find(pdt).name, products_hash))
    end
    @products_complementaires = produits_complementaires

    actifs_pdt = {}
    #fail
    #@photos_desktop = @photos + @photos + @photos + @photos
    #@photos_desktop = @photos.each_slice(3).to_a

    @labels = {
      "ECOCERT": "ecocert-organic.png",
      "Qualité Nature is Future": "charte-qualite.png",
      "FABRIQUÉ EN FRANCE": "fabrique-en-france.png",
      "NATUREL": "naturel.png",
      "PHYTOTHÉRAPIE INNOVANTE": "phytotherapie-innovante-responsable.png"
    }

    @yukacolor = 'green'
    case @product.yuka_appreciation
    when "Excellent"
      @yukacolor = "green"
    when "Bon"
      @yukacolor = "#94C52B"
    when "Médiocre"
      @yukacolor = "orange"
    when "Mauvais"
      @yukacolor = "red"
    end

  end

  def new
    @product = Product.new
    @actifs =  YAML.load_file("#{Rails.root.to_s}/db/yaml/actifs.yml").keys
    @ingredients =  YAML.load_file("#{Rails.root.to_s}/db/yaml/ingredients.yml")["ingredients"]
  end

  def create
    @product = Product.new(product_params)
    @product.actions_product.delete_if(&:blank?)
    @product.labels.delete_if(&:blank?)
    @product.types_peau.delete_if(&:blank?)
    @product.ingredients.delete_if(&:blank?)
    @product.product_actifs.delete_if(&:blank?)
    @product.types_produit.delete_if(&:blank?)
    @product.preoccupations.delete_if(&:blank?)
    @product.products_complementaires.delete_if(&:blank?)
    @product.save
    redirect_to products_path
  end

  def edit
    @product = Product.friendly.find(params[:id])
    @actifs =  YAML.load_file("#{Rails.root.to_s}/db/yaml/actifs.yml").keys
    @ingredients =  YAML.load_file("#{Rails.root.to_s}/db/yaml/ingredients.yml")["ingredients"]
  end

  def update
    @product = Product.friendly.find(params[:id])
    @product.update(product_params)
    @product.actions_product.delete_if(&:blank?)
    @product.labels.delete_if(&:blank?)
    @product.types_peau.delete_if(&:blank?)
    @product.ingredients.delete_if(&:blank?)
    @product.product_actifs.delete_if(&:blank?)
    @product.types_produit.delete_if(&:blank?)
    @product.preoccupations.delete_if(&:blank?)
    @product.products_complementaires.delete_if(&:blank?)
    @product.save
    redirect_to product_path(@product)
  end

  def categories
    @category = params[:category]
    add_breadcrumb "<strong>Produits #{@category.capitalize.upcase}</strong>".html_safe, cosmetique_category_path
    @cover =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")[@category]["cover"]
    @intro =  YAML.load_file("#{Rails.root.to_s}/db/yaml/categories.yml")[@category]["texte"]

    if params[:products].present? && params[:products].size != 0
      @products = Product.find(params[:products]).where(public:true)
    else
      @products = Product.where(gamme:@category).where(public:true)
    end
  end

  def filter
    @category = params[:filtrage][:category]
    if !params[:filtrage].nil? && params[:filtrage][:produits_types].values.include?("positive")
      x = params[:filtrage][:produits_types].as_json
      keys = []
      list_products = []
      x.each { |key,value| keys.push(key) if value == 'positive' }

      keys.each do |value|
        value = value.gsub("_"," ")
        list_products << Product.where(gamme: @category).where("'#{value}' = ANY (types_produit)").where(public:true)
      end

      if params[:filtrage][:besoins_types].values.include?("positive")
        x = params[:filtrage][:besoins_types].as_json
        keys = []
        list_products = []
        x.each { |key,value| keys.push(key) if value == 'positive' }

        keys.each do |value|
        value = value.gsub("_"," ")
        list_products << Product.where(gamme: @category).where("'#{value}' = ANY (preoccupations)").where(public:true)
        end

      end

      @products = list_products.flatten.uniq
      #redirect_to cosmetique_category_path(category:@category, products: @products)

      respond_to do |format|
        format.html { redirect_to cosmetique_category_path(category:@category, products: @products) }
        format.json
      end



    elsif !params[:filtrage].nil? && params[:filtrage][:besoins_types].values.include?("positive")

      x = params[:filtrage][:besoins_types].as_json
      keys = []
      list_products = []
      x.each { |key,value| keys.push(key) if value == 'positive' }

      keys.each do |value|
      value = value.gsub("_"," ")
      list_products << Product.where(gamme: @category).where("'#{value}' = ANY (preoccupations)").where(public:true)
      end

      @products = list_products.flatten.uniq
      #redirect_to cosmetique_category_path(category: @category, products: @products)
      respond_to do |format|
        format.html { redirect_to cosmetique_category_path(category:@category, products: @products) }
        format.json
      end

    else
      @products = Product.all.where(gamme:@category).where(public:true)
      #redirect_to cosmetique_category_path(category: @category, products: @products)
      respond_to do |format|
        format.html { redirect_to cosmetique_category_path(category:@category, products: @products) }
        format.json
      end
    end
  end

  def destroy
  end

  def delete_photo
    product = Product.friendly.find(params[:id])
    #photo_to_delete = product.photos.where(id:params[:photo])
    product.photos.where(id:params[:photo]).purge
    redirect_to edit_product_path(product)
  end

  def click_and_collect
    @product = Product.friendly.find(params[:pdt]) if Product.friendly.find(params[:pdt]).public == true
    #@instituts = Institut.all.stock_institut.pdt_stock_items.where(product_id:@product.id)
    pdts_in_stock = PdtStockItem.where(product_id:@product.id).where("quantity > 0")

    add_breadcrumb "Cosmétiques".upcase.html_safe, products_path
    add_breadcrumb "<strong>Click & collect</strong>".html_safe, click_collect_products_path

    @page_title = "Click & collect | Retrouvez nos cosmétiques dans les instituts | Nature is Future Pro"
    @page_description = ""


    @instituts = []
    pdts_in_stock.each do |stock|
      @instituts << stock.stock_institut.institut if ((Time.now - stock.stock_institut.updated_at)/86400 < 30)
    end

    @instituts = Institut.where(id: @instituts.map(&:id))
    @markers = @instituts.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat}),
        marker_html: render_to_string(partial: "marker", locals: {flat: flat})
      }
    end
  end
  private

  def product_params
    params.require(:product).permit(:name,:description,:price_ht,:texture,:gamme,:utilisation,:contenance_revente,:contenance_cabine,:yuka_appreciation,:product_plus,:product_conseil,:product_gestes,:public,ingredients: [], product_actifs: [], actions_product: [], labels:[], types_peau:[], types_produit:[],preoccupations:[],photos: [],products_complementaires: [])
  end
end
