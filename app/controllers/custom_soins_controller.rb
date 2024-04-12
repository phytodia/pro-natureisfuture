class CustomSoinsController < ApplicationController
  layout "espace"
  def index
    @custom_soins = CustomSoin.all.where(customer_id:current_customer)
  end
  def new
    @custom_soin = CustomSoin.new
    @products = Product.all.where(public:true)
  end

  def create
    @custom_soin = CustomSoin.new(custom_soin_params)
    @custom_soin.customer = current_customer

    params[:custom_soin][:product_ids] = params[:custom_soin][:product_ids].reject(&:blank?)
    params[:custom_soin][:product_ids].each do |pdt_id|
      @custom_soin.products << Product.find(pdt_id)
    end
    if @custom_soin.save
      redirect_to custom_soins_path
    else
      rendre :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def custom_soin_params
    params.require(:custom_soin).permit(:name,:description,:category,:estimated_time,:price_ttc)
  end
end
