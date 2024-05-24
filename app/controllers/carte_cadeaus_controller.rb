class CarteCadeausController < ApplicationController
  layout "espace"
  def index
    @cartes_cadeau = CarteCadeau.where(institut_id: current_customer.instituts.ids)
    @valid_cartes = @cartes_cadeau.where("date_expiration > ?",Time.now)
    @expirated_cartes = @cartes_cadeau.where("date_expiration < ?",Time.now)
  end

  def new
    @carte_cadeau = CarteCadeau.new
  end

  def create
    @carte_cadeau = CarteCadeau.new(carte_params)
    #params[:soin][:product_ids] = params[:soin][:product_ids].reject(&:blank?)
    #params[:soin][:product_ids].each do |pdt_id|
      #@soin.products << Product.find(pdt_id)
    #end
    if @carte_cadeau.save
      redirect_to carte_cadeaus_path
    else
      rendre :new
    end
  end

  def destroy
    @carte = CarteCadeau.find(params[:id])
    @carte.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to carte_cadeaus_path
  end

  def send_cheque
    InstitutMailer.send_cheque().deliver_now
  end

  private
  def carte_params
    params.require(:carte_cadeau).permit(:destinataire,:expediteur,:offre,:date_expiration,:message,:institut_id,:status)
  end
end
