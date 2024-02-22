class CartesController < ApplicationController
  def new
    @carte = Carte.new
    @carte.carte_soins.build
    @customer = current_customer
    @instituts = current_customer.instituts
  end

  def create

    @carte = Carte.new(carte_params)
    @carte.institut_id = params[:carte][:institut]
    @institut = Institut.find(params[:carte][:institut])

    #params[:carte][:soin_ids] = params[:carte][:soin_ids].reject(&:blank?)
    #params[:carte][:soin_ids].each do |soin_id|
    #  @carte.soins << Soin.find(soin_id)
    #end
    @carte.carte_soins.clear

    soins_nif = params[:carte][:carte_soins_attributes]

    soins_nif.keys.each do |key|
      if soins_nif[key]["estimated_time"] != ""
        x = CarteSoin.new(estimated_time: soins_nif[key]["estimated_time"],soin_id:soins_nif[key]["soin_id"], price_ttc: Money.new(soins_nif[key]["price_ttc"].to_i * 100))
        x.save
        @carte.carte_soins << x
      end
      #x = CarteSoin.new(estimated_time: soins_nif[key]["estimated_time"],soin_id:soins_nif[key]["soin_id"])
      #x.save
      #@carte.carte_soins << x
    end
    params[:carte][:custom_soin_ids] = params[:carte][:custom_soin_ids].reject(&:blank?)
    params[:carte][:custom_soin_ids].each do |custom_soin_id|
      x = CarteSoin.new(custom_soin_id: custom_soin_id.to_i, estimated_time: CustomSoin.find(custom_soin_id.to_i).estimated_time, price_ttc:CustomSoin.find(custom_soin_id.to_i).price_ttc )
      x.save
      @carte.carte_soins << x
      #@carte.custom_soins << CustomSoin.find(custom_soin_id)
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
    @carte = Carte.find(params[:id])
  end

  def update
    @institut = Institut.find(params[:institut_id])
    @carte = Carte.find(params[:id])
    @carte.update(carte_params)
    redirect_to institut_espace_pro_index_path(@institut)
  end

  def destroy
    @carte = Carte.find(params[:id])
    @institut = @carte.institut
    @carte.destroy
    redirect_to  institut_espace_pro_index_path(@institut)

    #redirect_to restaurants_path, status: :see_other
  end

  private
  def carte_params
    params.require(:carte).permit(:insitut,:soin_ids,:custom_soins,carte_soins_attributes:[:estimated_time,:price_ttc])
  end
end
