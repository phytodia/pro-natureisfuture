class CarteCadeausController < ApplicationController
  layout "espace"
  def index
  end

  def new
    @carte_cadeau = CarteCadeau.new
  end

  def create
    @carte_cadeau = CarteCadeau.new(carte_params)
    fail
    #params[:soin][:product_ids] = params[:soin][:product_ids].reject(&:blank?)
    #params[:soin][:product_ids].each do |pdt_id|
      #@soin.products << Product.find(pdt_id)
    #end
    if @carte_cadeau.save
      redirect_to soins_path
    else
      rendre :new
    end
  end

  def destroy
  end

  private
  def carte_params
    params.require(:carte_cadeau).permit(:destinatare,:expediteur,:price,:date_expiration,:message)
  end
end
