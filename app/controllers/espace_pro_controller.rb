class EspaceProController < ApplicationController

  before_action :authenticate_customer!, except:[:index]
  before_action :check_palier, except:[:index]

  include OrdersHelper

  layout "espace", except: [:index]

  def index
    if !current_customer.nil?
      redirect_to espace_pro_path(current_customer)
    end
  end

  def show
    current_orders = current_customer.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?",Date.today.year,"Payée")
    #current_trimestre_amount = current_customer.total_trimestre()

    ids_instituts = current_customer.instituts.ids
    @datas_first = Ahoy::Event.where(name: "institut_view")
    data_emails_institut = Ahoy::Event.where(name: "institut_rdv_send")
    @visits = []
    @rdvs_send = []

    ids_instituts.each do |id|
      @visits << @datas_first.where("properties @> ?", { institut_id: id }.to_json)
      @rdvs_send << data_emails_institut.where("properties @> ?", { institut_id: id }.to_json)
    end
    @rdvs_send = @rdvs_send.compact_blank
    rdvs = current_customer.message_instituts.last(3)
    @rdvs = MessageInstitut.where(id: rdvs.map(&:id))

    @mediateque_folders = PhotothequeEspaceProFolder.all.where(public:true).where(category:"Mediatheque")
    @documents_folders = PhotothequeEspaceProFolder.all.where(public:true).where(category:"Documents")

  end

  def etablissements
    @instituts = Institut.all.where(customer_id: current_customer.id)
  end

  def institut_show
    @institut = Institut.friendly.find(params[:id])
    @current_customer = current_customer
    @carte_nif = @institut.carte.carte_soins.where.not(soin_id: nil).where.not(estimated_time:"") if !@institut.carte.nil?
    @carte_custom = @institut.carte.custom_soins if !@institut.carte.nil?
    @carte = @institut.carte
    @flat = @institut
    @marker = [{
      lat: @flat.latitude,
      lng: @flat.longitude,
      marker_html: render_to_string(partial: "marker", locals: {flat: @flat})
    }]

    if @institut.customer != @current_customer
      redirect_to espace_pro_path(current_customer)
    end
  end

  def edit_institut
    @institut = Institut.friendly.find(params[:id])
    @regions =  YAML.load_file("#{Rails.root.to_s}/db/yaml/regions.yml")["France"].sort
  end

  def update_institut
    x = institut_params[:horaires].to_hash.to_a.each_slice(4).to_a
    days = ["lundi","mardi","mercredi","jeudi","vendredi","samedi","dimanche"]
    my_hash = {}
    days.each_with_index do |day, index|
      my_hash[day] = {am_1:"",am_2:"",pm_1:"",pm_2:""}
      my_hash[day][:am_1] = x[index][0][1]
      my_hash[day][:am_2] = x[index][1][1]
      my_hash[day][:pm_1] = x[index][2][1]
      my_hash[day][:pm_2] = x[index][3][1]
    end

    @institut = Institut.find(params[:institut][:institut_id])
    @institut.update(institut_params)
    @institut.customer_id = Institut.find(params[:institut][:institut_id]).customer_id
    @institut.update(horaires:my_hash)

    if @institut.save
      redirect_to institut_espace_pro_index_path(@institut), notice: "L'institut a pas été mis à jour"
    else
      redirect_to edit_institut_path , alert: "L'institut n'a pas été mis à jour"
    end
  end

  def produits

  end

  def cours
  end

  def faq
  end
  def phototheque
    @phototheque = PhotothequeEspacePro.last
  end

  def phototheque_folder
    @folder = PhotothequeEspaceProFolder.find(params[:folder_id])
  end

  def rdv
    @rdvs = current_customer.message_instituts
  end

  def update_status
    MessageInstitut.find(params[:message_id]).toggle!(:read)
    redirect_to rendez_vous_espace_pro_path(params[:id])
  end

  def addnote
    @rdv = MessageInstitut.find(params[:note][:message_id])
    @rdv.note = params[:note][:note]
    @rdvs = current_customer.message_instituts

    respond_to do |format|
      if @rdv.save
        puts @rdv.note
        format.html { redirect_to rendez_vous_espace_pro_path(current_customer.id) }
        format.json # Follows the classic Rails flow and look for a create.json view
      else
        format.html
        format.json # Follows the classic Rails flow and look for a create.json view
      end
    end
  end

  def commandes
    @orders = current_customer.orders
  end
  def delete_photo
    institut = Institut.friendly.find(params[:institut])
    #photo_to_delete = product.photos.where(id:params[:photo])
    institut.photos.where(id:params[:photo]).purge
    redirect_to edit_institut_espace_pro_index_path(institut)
  end

  def delete_promo
    institut = Institut.friendly.find(params[:institut])
    #photo_to_delete = product.photos.where(id:params[:photo])
    institut.promo_photo.purge
    redirect_to edit_institut_espace_pro_index_path(institut)
  end

  def edit_profile
    @customer = current_customer
  end
  def update_profile
    @customer = Customer.find(params[:id])
    @customer.update(profile_params)
    # No need for app/views/restaurants/update.html.erb
    redirect_to  espace_pro_path(@customer)
  end

  def statistiques
    ids_instituts = current_customer.instituts.ids
    @datas_first = Ahoy::Event.where(name: "institut_view")
    @visits = []
    ids_instituts.each do |id|
      @visits << @datas_first.where("properties @> ?", { institut_id: id }.to_json)
    end
  end


  private
  def check_profile
    @profile = Profile.find(current_customer.profile.id)
    #redirect_to espace_pro_index_path
  end

  def check_palier
    @avantages = ["O%","-10%","-15%","-25%"]
    @last_palier = Customer::PALIERS.last
    @orders = Order.where(customer_id:current_customer)
    t = current_customer.total_trimestre.to_f / @last_palier
    #fail
    #t = t.floor(1)
    t = t * 3 # array des avantages - 1
    @index_avantage = (t).to_i

    current_trimestre = trimestre(Date.today)
    if current_trimestre[:index] == 0
      year = Date.today.year - 1
      orders_year = current_customer.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?", year,"Payée")

    else
      orders_year = current_customer.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?", year,"Payée")
    end
    orders_last_trimestre = last_trimestre_orders(orders_year, current_trimestre[:index])
    @last_trimestre_amount = current_customer.last_trimestre_amount(orders_last_trimestre)
    @amount_avantages_ht = current_customer.last_trimestre_amount(orders_last_trimestre)
  end

  def institut_params
    params.require(:institut).permit(:name,:description,:tel,:address,:cp,:city,:country,:latitude,:longitude,:email,:website,:category,:fb,:ig,:tik_tok,:rdv,:mess_promo,:promo_photo,:region,:customer_id,horaires:{},photos: [])
  end
  def profile_params
    params.require(:customer).permit(:lastname,:firstname,:email,:tel,:password,:photo)
  end

end
