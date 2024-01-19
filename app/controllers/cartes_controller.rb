class CartesController < ApplicationController
  def new
    @carte = Carte.new
    @customer = current_customer
    @instituts = current_customer.instituts
  end

  def create

    @carte = Carte.new(carte_params)
    @carte.institut_id = params[:carte][:institut]
    @institut = Institut.find(params[:carte][:institut])

    params[:carte][:soin_ids] = params[:carte][:soin_ids].reject(&:blank?)
    params[:carte][:soin_ids].each do |soin_id|
      @carte.soins << Soin.find(soin_id)
    end

    params[:carte][:custom_soin_ids] = params[:carte][:custom_soin_ids].reject(&:blank?)
    params[:carte][:custom_soin_ids].each do |custom_soin_id|
      @carte.custom_soins << CustomSoin.find(custom_soin_id)
    end

    @carte.save!
    if @carte.save
      redirect_to institut_espace_pro_index_path(@institut)
    else
      rendre :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def carte_params
    params.require(:carte).permit(:insitut,:soin_ids,:custom_soins)
  end
end
