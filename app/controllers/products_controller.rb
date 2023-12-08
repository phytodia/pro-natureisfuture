class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.actions_product.delete_if(&:blank?)
    @product.save
    redirect_to products_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
  def product_params
    params.require(:product).permit(:name,:description,:labels,:types_peau,:texture,:gamme,:utilisation,:contenances,:yuka_appreciation,:product_conseil,:product_gestes,:ingredients,actions_product: [])
  end
end