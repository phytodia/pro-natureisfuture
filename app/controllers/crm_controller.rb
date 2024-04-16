class CrmController < ApplicationController
  layout "crm"
  #devise_group :crm, contains: [:user,:commercial]
  before_action :authenticate_commercial!
  #before_action :authenticate_crm!

  include CrmHelper

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def crm_prospects
    @prospects = Prospect.all.where(commercial_id: current_commercial.id)
    @colors = {"nouveau": "blue","client":"green","en cours de traitement":"orange"}
    if params[:filter].present?
      @prospects = @prospects.order("#{params[:filter]} #{params[:order].upcase}")
    else
      @prospects = Prospect.all.where(commercial_id: current_commercial.id)
    end
  end

  def show_prospect
    @prospect = Prospect.find(params[:id])
    @prospect_coord = Geocoder.search(@prospect.full_address).first.coordinates

    @instituts = Institut.all

    # The `geocoded` scope filters only flats with coordinates
    #url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    #base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

    #params = {
    #  location: '48.0777517,7.3579641',
    #  radius: 1500,
    #  type: 'beauty_salon',  # Vous pouvez ajuster le type en fonction de vos besoins
    #  key: 'AIzaSyC74ObwjB-HWFHBjvCyZUpgduKw-uQQ7a4'
    #}
    #response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@inst_coord[0]},#{@inst_coord[1]}&radius=15000&type=beauty_salon&key=AIzaSyC74ObwjB-HWFHBjvCyZUpgduKw-uQQ7a4")

    #@results = response.parsed_response['results']

    def get_places_results(url, params)
      results = []
      loop do
        response = HTTParty.get(url, query: params)
        data = response.parsed_response

        # Vérifiez si la requête a réussi
        if response.code == 200
          results.concat(data.fetch('results', []))

          # Vérifiez s'il y a une page suivante
          if data.key?('next_page_token')
            # Attendez quelques secondes pour que la page suivante soit disponible
            sleep(2)

            # Utilisez le token de page pour obtenir les résultats de la page suivante
            params[:pagetoken] = data['next_page_token']
          else
            # Pas de page suivante, sortie de la boucle
            break
          end
        else
          puts "Erreur de requête: #{response.code}"
          puts response.body
          break
        end
      end

      results
    end

    base_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

    # Définissez vos paramètres communs

    params = {
      location: @prospect_coord.compact.join(', '),
      radius: 20000,
      type: 'beauty_salon',
      key: ENV["GOOGLE_MAP_API"]
    }

    # Obtenez les résultats pour toutes les pages
    @all_results = get_places_results(base_url, params)

    # Traitez les résultats
    @all_results.each do |place|
      puts "#{place['name']} - #{place['vicinity']} - status : #{place["business_status"]} - lat: #{place['geometry']['location']['lat']} - lng: #{place['geometry']['location']['lng']}, cat: #{place['types']}, rating_number: #{place['user_ratings_total']}, note: #{place['rating']}"
    end


    @markers_conc = @all_results

    @markers = @markers_conc.map do |flat|
      {
        lat: flat["geometry"]["location"]["lat"],
        lng: flat["geometry"]["location"]["lng"],
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def new_prospect
    @prospect = Prospect.new
  end
  def create_prospect
    @prospect = Prospect.new(prospect_params)
    if @prospect.save
      redirect_to prospects_crm_index_path(current_commercial.id)
    end
  end

  def edit_prospect
    @prospect = Prospect.find(params[:id])
  end
  def update_prospect
    @prospect = Prospect.find(params[:id])
    @prospect.update(prospect_params)
    # No need for app/views/restaurants/update.html.erb
    redirect_to prospects_crm_index_path
  end

  def crm_customers
    @commercial = current_commercial
    @clients = Customer.all.where(commercial_id: @commercial.id)
    if params[:filter].present?
      @clients = @clients.order("#{params[:filter]} #{params[:order].upcase}")
    else
      @clients = Customer.all.where(commercial_id: @commercial.id)
    end
  end

  def new_customer
    if !params[:prospect].nil? && params[:prospect] != ""
      @prospect = Prospect.find(params[:prospect])
    end
    @customer = Customer.new
  end

  def create_customer
    @customer = Customer.new(customer_params)
    if customer_params[:prospect_id] != ""
      Prospect.find(@customer.prospect_id).update!(statut:"client")
      if @customer.save
        redirect_to clients_crm_index_path(current_commercial.id), notice: "Le prospect a été correctement transformé en client"
      else
        render :new
      end
    else
      if @customer.save
        redirect_to clients_crm_index_path(current_commercial.id), notice: "Le client a été crée avec succès"
      else
        render :new
      end
    end

  end

  def show_customer
    @customer =  Customer.find(params[:id])
    @instituts = @customer.instituts
    @orders = Order.where(customer_id:@customer.id)
    @order_products = []
    @orders.each do |order|
      @order_products << order.order_products
    end
    @order_products = @order_products.flatten.reject { |order_product| order_product.quantity.nil? || order_product.quantity == 0 }.group_by(&:product_id)

    @orders_hash = {
        (Date.today.year).to_s => {
          "january" => {
            "all" =>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "february"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "march"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "april"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "may"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "june"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "july"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "august"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "september"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "october"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "november"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "december"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          }
        },
        (Date.today.year-1).to_s => {
          "january" => {
            "all" =>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "february"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "march"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "april"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "may"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "june"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "july"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "august"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "september"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "october"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "november"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          },
          "december"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre_cmd"=>0
          }
        }
    }
    @orders = @customer.orders.order(custom_date: :asc)
    @orders.each do |order|
      if @orders_hash.keys.include?(order.custom_date.year.to_s)
        @orders_hash[order.custom_date.year.to_s][Date::MONTHNAMES[order.custom_date.month].downcase]["nombre_cmd"] += 1
        @orders_hash[order.custom_date.year.to_s][Date::MONTHNAMES[order.custom_date.month].downcase]["all"] += order.amount_ht.fractional
        if order.state == "Payée"
          @orders_hash[order.custom_date.year.to_s][Date::MONTHNAMES[order.custom_date.month].downcase]["Payée"] += order.amount_ht.fractional
        end
      end
    end
    @orders_hash = @orders_hash.transform_values! { |v| v.empty? || !v ? 0 : v }

  end

  def edit_customer
    @customer = Customer.find(params[:id])
  end

  def update_customer
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    # No need for app/views/restaurants/update.html.erb
    redirect_to clients_crm_index_path(current_commercial)
  end

  def new_institut
    @institut = Institut.new
    @regions =  YAML.load_file("#{Rails.root.to_s}/db/yaml/regions.yml")["France"].sort
    @institut.horaires = { lundi: {am_1:"",am_2:"",pm_1:"",pm_2:""},mardi: {am_1:"",am_2:"",pm_1:"",pm_2:""},mercredi: {am_1:"",am_2:"",pm_1:"",pm_2:""},jeudi: {am_1:"",am_2:"",pm_1:"",pm_2:""},vendredi: {am_1:"",am_2:"",pm_1:"",pm_2:""},samedi: {am_1:"",am_2:"",pm_1:"",pm_2:""},dimanche: {am_1:"",am_2:"",pm_1:"",pm_2:""}}
    @days = [:lundi, :mardi,:mercredi,:jeudi,:vendredi,:samedi,:dimanche]
  end

  def create_institut
    @institut = Institut.new(institut_params)
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

    @institut.horaires = my_hash

    if @institut.save
      redirect_to customer_crm_index_path(@institut.customer_id), notice: "L'établissement a été correctement crée"
    else
      render :new
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

    #@institut = Institut.find(params[:institut][:institut_id])

    #@institut.customer_id = Institut.find(params[:institut][:institut_id]).customer_id

    #@institut.horaires = my_hash

    @institut = Institut.find(params[:institut][:institut_id])
    @institut.update(institut_params)
    @institut.customer_id = Institut.find(params[:institut][:institut_id]).customer_id
    @institut.update(horaires:my_hash)



    if @institut.save
      redirect_to crm_index_path(current_commercial), notice: "Update ok"
    else
      redirect_to edit_institut_crm_index_path , alert: "L'établissement n'a pas été mis à jour"
    end
    # No need for app/views/restaurants/update.html.erb

  end


  def destroy
  end

  def delete_photo
    institut = Institut.friendly.find(params[:institut])
    #photo_to_delete = product.photos.where(id:params[:photo])
    institut.photos.where(id:params[:photo]).purge
    redirect_to edit_institut_crm_index_path(institut)
  end

  def statistiques
    @commercial = current_commercial

    @prospects = Prospect.all.where(commercial_id:@commercial.id)
    @new_prospects =  @prospects.where(statut:"nouveau")
    @clients = @prospects.where(statut:"client")
    @en_cours = @prospects.where(statut:"en cours de traitement")

    @customers = Customer.where(commercial_id:@commercial.id)
    @orders = []
    @customers.each { |customer| @orders << customer.orders }
    @orders = @orders.flatten
    @orders = Order.where(id: @orders.map(&:id))


    ### Datas pour les prospects

    prospects_2024 = Prospect.where(commercial_id:@commercial).where("EXTRACT(year FROM date_prospect) = ?", Date.today.year)

    janvier = prospects_2024.select { |item| item.date_prospect.month == 1 }
    fevrier = prospects_2024.select { |item| item.date_prospect.month == 2 }
    mars = prospects_2024.select { |item| item.date_prospect.month == 3 }
    avril = prospects_2024.select { |item| item.date_prospect.month == 4 }
    mai = prospects_2024.select { |item| item.date_prospect.month == 5 }
    juin = prospects_2024.select { |item| item.date_prospect.month == 6 }
    juillet = prospects_2024.select { |item| item.date_prospect.month == 7 }
    aout = prospects_2024.select { |item| item.date_prospect.month == 8 }
    septembre = prospects_2024.select { |item| item.date_prospect.month == 9 }
    octobre = prospects_2024.select { |item| item.date_prospect.month == 10 }
    novembre = prospects_2024.select { |item| item.date_prospect.month == 11 }
    decembre = prospects_2024.select { |item| item.date_prospect.month == 12 }

    @prospects_current_year = prospects_2024.count

    #prospects_2024 = Prospect.where(commercial_id:@commercial).where("EXTRACT(year FROM date_prospect) = ?", Date.today.year)

    var_datas = ["nouveau","en cours de traitement","refus","client"]
    @data_prospects = [
      {name:"Nouveau",
        data: [["Janvier",janvier.select { |item| item.statut == var_datas[0] }.count],["Février",fevrier.select { |item| item.statut == var_datas[0] }.count],["Mars",mars.select { |item| item.statut == var_datas[0] }.count],["Avril",avril.select { |item| item.statut == var_datas[0] }.count],["Mai",mai.select { |item| item.statut == var_datas[0] }.count],["Juin",juin.select { |item| item.statut == var_datas[0] }.count],["Juillet",juillet.select { |item| item.statut == var_datas[0] }.count],["Août",aout.select { |item| item.statut == var_datas[0] }.count],["Septembre",septembre.select { |item| item.statut == var_datas[0] }.count],["Octobre",octobre.select { |item| item.statut == var_datas[0] }.count],["Novembre",novembre.select { |item| item.statut == var_datas[0] }.count],["Décembre",decembre.select { |item| item.statut == var_datas[0] }.count]]},
      {name:"En cours de traitement",
        data: [["Janvier",janvier.select { |item| item.statut == var_datas[1] }.count],["Février",fevrier.select { |item| item.statut == var_datas[1] }.count],["Mars",mars.select { |item| item.statut == var_datas[1] }.count],["Avril",avril.select { |item| item.statut == var_datas[1] }.count],["Mai",mai.select { |item| item.statut == var_datas[1] }.count],["Juin",juin.select { |item| item.statut == var_datas[1] }.count],["Juillet",juillet.select { |item| item.statut == var_datas[1] }.count],["Août",aout.select { |item| item.statut == var_datas[1] }.count],["Septembre",septembre.select { |item| item.statut == var_datas[1] }.count],["Octobre",octobre.select { |item| item.statut == var_datas[1] }.count],["Novembre",novembre.select { |item| item.statut == var_datas[1] }.count],["Décembre",decembre.select { |item| item.statut == var_datas[1] }.count]]},
      {name:"Refus",
        data: [["Janvier",janvier.select { |item| item.statut == var_datas[2] }.count],["Février",fevrier.select { |item| item.statut == var_datas[2] }.count],["Mars",mars.select { |item| item.statut == var_datas[2] }.count],["Avril",avril.select { |item| item.statut == var_datas[2] }.count],["Mai",mai.select { |item| item.statut == var_datas[2] }.count],["Juin",juin.select { |item| item.statut == var_datas[2] }.count],["Juillet",juillet.select { |item| item.statut == var_datas[2] }.count],["Août",aout.select { |item| item.statut == var_datas[2] }.count],["Septembre",septembre.select { |item| item.statut == var_datas[2] }.count],["Octobre",octobre.select { |item| item.statut == var_datas[2] }.count],["Novembre",novembre.select { |item| item.statut == var_datas[2] }.count],["Décembre",decembre.select { |item| item.statut == var_datas[2] }.count]]},
      {name:"Client",
        data: [["Janvier",janvier.select { |item| item.statut == var_datas[3] }.count],["Février",fevrier.select { |item| item.statut == var_datas[3] }.count],["Mars",mars.select { |item| item.statut == var_datas[3] }.count],["Avril",avril.select { |item| item.statut == var_datas[3] }.count],["Mai",mai.select { |item| item.statut == var_datas[3] }.count],["Juin",juin.select { |item| item.statut == var_datas[3] }.count],["Juillet",juillet.select { |item| item.statut == var_datas[3] }.count],["Août",aout.select { |item| item.statut == var_datas[3] }.count],["Septembre",septembre.select { |item| item.statut == var_datas[3] }.count],["Octobre",octobre.select { |item| item.statut == var_datas[3] }.count],["Novembre",novembre.select { |item| item.statut == var_datas[3] }.count],["Décembre",decembre.select { |item| item.statut == var_datas[3] }.count]]}
    ]
    ## Fin prospects

    ## Nuage de points

    data_nuage_n = []
    data_nuage_n_1 = []
    @commercial.customers.each do |customer|
      customer_amount_ht = customer.total_facture_n(Date.today.year)
      customer_amount_ht = customer_amount_ht.fractional/100 if customer_amount_ht != 0
      customer_orders_qty = customer.orders_n(Date.today.year).size
      fullname = customer.lastname + " " + customer.firstname
      data_nuage_n << {name: fullname, data: {customer_orders_qty => customer_amount_ht }}
    end

    @commercial.customers.each do |customer|
      customer_amount_ht = customer.total_facture_n(Date.today.year-1)
      customer_amount_ht = customer_amount_ht.fractional/100 if customer_amount_ht != 0
      customer_orders_qty = customer.orders_n(Date.today.year-1).size
      fullname = customer.lastname + " " + customer.firstname
      data_nuage_n_1 << {name: fullname, data: {customer_orders_qty => customer_amount_ht }}
    end
    @data_nuage_n = data_nuage_n
    @data_nuage_n_1 = data_nuage_n_1

    ### Barres commandes année n Montant cmds + Montants payés + Montants payés n-1
    #ca_n = 0 #montant de l'ensemble des commandes de l'année n en cours (payées ou non)
    #ca_paye_n = 0 #CA payé pour l'année n
    #ca_paye_n_1 = 0 #CA payé pour l'année n-1

    #orders_test = Order.pluck(:custom_date)

    orders_all = current_commercial.commercial_orders.where("EXTRACT(year FROM custom_date) = ?", Date.today.year) + current_commercial.commercial_orders.where("EXTRACT(year FROM custom_date) = ?", Date.today.year-1)

    orders_all = orders_all.pluck(:customer_id,:amount_ht_cents,:state,:custom_date,:id)
    #fail
    ## Identifier les orders par commercial
    ## Scinder les orders par année et par mois
    customers_id = @commercial.customers.pluck(:id)

    orders_commercial = []
    orders_n = []
    orders_n_1 = []
    orders_n_payed = []
    orders_n_1_payed = []
    @amount_n = 0
    @amount_n_payed = 0
    @amount_n_1 = 0
    @amount_n_1_payed = 0

    @amount_hash = {
        (Date.today.year).to_s => {
          "january" => {
            "all" =>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "february"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "march"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "april"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "may"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "june"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "july"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "august"=>{
            "all"=>0,
            "Payée"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "september"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "october"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "november"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "december"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          }
        },
        (Date.today.year-1).to_s => {
          "january" => {
            "all" =>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "february"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "march"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "april"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "may"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "june"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "july"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "august"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "september"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "october"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "november"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          },
          "december"=>{
            "all"=>0,
            "Payée"=>0,
            "reassort"=>0,
            "nombre"=>0,
            "ouvert_customers_payed"=>0,
            "ouvert_customers_count"=>0
          }
        }
    }

    orders_all.each do |order|
      if customers_id.include?(order[0])
        orders_commercial << order
      end
    end


    orders_n.each {|order| @amount_n+= order[1]}
    orders_n_1.each {|order| @amount_n_1+= order[1]}

    orders_n_payed.each {|order| @amount_n_payed+= order[1]}
    orders_n_1_payed.each {|order| @amount_n_1_payed+= order[1]}

    puts orders_commercial.class
    puts orders_commercial

    orders_commercial.each do |order|
      puts "Erreur : #{order[2]}"
      #fail

      ## new
      if order[3].year == Date.today.year
        orders_n << order
        orders_n_payed << order if order[2] == "Payée"
      elsif order[3].year == Date.today.year-1
        orders_n_1 << order
        orders_n_1_payed << order if order[2] == "Payée"
      end

      ## fin new
      somme = 0

      if order[3] != nil && order[2] != nil
        order_date = order[3]
        order_state = order[2]
        puts "id du client #{order.first} - id de l'order#{order.last}"

        if @amount_hash[order_date.year.to_s][Date::MONTHNAMES[order_date.month].downcase][order_state].present?
          somme = @amount_hash[order[3].year.to_s][Date::MONTHNAMES[order[3].month].downcase][order[2]]
          somme = somme + order[1]
          @amount_hash[order[3].year.to_s][Date::MONTHNAMES[order[3].month].downcase][order[2]] = somme
        end
      end
    end

    orders_commercial.each do |order|
      ## Nombre
      @amount_hash[order[3].year.to_s][Date::MONTHNAMES[order[3].month].downcase]["nombre"] += 1
      @amount_hash[order[3].year.to_s][Date::MONTHNAMES[order[3].month].downcase]["all"] += order[1]
    end

    ## FAIL

    ## Tableau commandes par mois
    ouvertures_customers_n = []
    ouvertures_customers_n_1 = []
    #@ouvert_mois_n = [["janvier",[]],["février",[]],["mars",[]],["avril",[]],["mai",[]],["juin",[]],["juillet",[]],["août",[]],["septembre",[]],["octobre",[]],["novembre",[]],["décembre",[]]]
    #@ouvert_mois_n_1 = [["janvier",[]],["février",[]],["mars",[]],["avril",[]],["mai",[]],["juin",[]],["juillet",[]],["août",[]],["septembre",[]],["octobre",[]],["novembre",[]],["décembre",[]]]

    @ouvert_total_n = 0
    @ouvert_total_n_1 = 0
    @commercial.customers.each do |customer|
      orders = customer.orders.order(custom_date: :asc)
      if !orders.first.nil?  && orders.first.custom_date.year == Date.today.year
        ouvertures_customers_n << customer
      elsif !orders.first.nil?  && orders.first.custom_date.year == Date.today.year-1
        ouvertures_customers_n_1 << customer
      end
    end

    ouvertures_customers_n.each do |client_ouv|
      @amount_hash[client_ouv.orders.order(custom_date: :asc).first.custom_date.year.to_s][Date::MONTHNAMES[client_ouv.orders.order(custom_date: :asc).first.custom_date.month].downcase]["ouvert_customers_payed"] += client_ouv.orders.order(custom_date: :asc).first.amount_ht.fractional if client_ouv.orders.order(custom_date: :asc).first.state == "Payée"
      #@ouvert_mois_n[client_ouv.orders.order(custom_date: :asc).first.custom_date.month-1][1].push(client_ouv.orders.order(custom_date: :asc).first.amount_ht.fractional) if client_ouv.orders.order(custom_date: :asc).first.state == "Payée"
    end

    #ouvertures_customers_n_1.each do |client_ouv|
      #@ouvert_mois_n_1[client_ouv.orders.order(custom_date: :asc).first.custom_date.month-1][1].push(client_ouv.orders.order(custom_date: :asc).first.amount_ht.fractional) if client_ouv.orders.order(custom_date: :asc).first.state == "Payée"
    #end



    #@ouvert_mois_n.each do |mois|
    #  mois[1] = mois[1].sum
    #  @ouvert_total_n += mois[1]
    #end
    #@ouvert_mois_n_1.each do |mois|
    #  mois[1] = mois[1].sum
    #  @ouvert_total_n_1 += mois[1]
    #end

    ## Les réassorts (montants par mois)
    @commercial.customers.each do |customer|
      if customer.orders.size > 1
        orders = customer.orders.where("EXTRACT(year FROM custom_date) = ?", Date.today.year).where(state:"Payée").order(custom_date: :asc)
        orders.each do |order|
          if customer.orders.where(state:"Payée").order(custom_date: :asc).first != order
            sum = @amount_hash[(Date.today.year).to_s][Date::MONTHNAMES[order.custom_date.month].downcase]["reassort"] ||=0
            sum += order.amount_ht.fractional
            @amount_hash[(Date.today.year).to_s][Date::MONTHNAMES[order.custom_date.month].downcase]["reassort"] = sum
          end
        end
      end
    end


    @total_reassort_n = @amount_hash[(Date.today.year).to_s].values.map {|item| item["reassort"] }
    @total_facture_n = @total_reassort_n.map {|e| e ? e : 0} ## IMPORTANT
    @total_facture_n = @total_facture_n.sum


    ## Graphique commandes 2024
    @reassort_datas = [["january",[]],["february",[]],["march",[]],["april",[]],["may",[]],["june",[]],["july",[]],["august",[]],["september",[]],["october",[]],["november",[]],["december",[]]]
    #@ouvert_mois_n #@ouvert_mois_n = [["janvier",[]],["février",[]],["mars",[]],["avril",[]],["mai",[]],["juin",[]],["juillet",[]],["août",[]],["septembre",[]],["octobre",[]],["novembre",[]],["décembre",[]]]
    @total_reassort_n.map {|e| e ? e : 0}.each_with_index do |val,index|
      @reassort_datas[index][1] = Money.new(val).format.delete_prefix('€')
    end

    data_ouvertures_n = [["january",[]],["february",[]],["march",[]],["april",[]],["may",[]],["june",[]],["july",[]],["august",[]],["september",[]],["october",[]],["november",[]],["december",[]]]
    @data_ouvertures_n = data_ouvertures_n.each {|item| item[1] = Money.new(@amount_hash[Date.today.year.to_s][item[0]]["ouvert_customers_payed"]).format.delete_prefix('€') }

    @data_montants_n = [["january",[]],["february",[]],["march",[]],["april",[]],["may",[]],["june",[]],["july",[]],["august",[]],["september",[]],["october",[]],["november",[]],["december",[]]]
    ## A modifier
    @amount_hash[(Date.today.year).to_s].keys.each_with_index do |mois,index|
      @data_montants_n[index][1] = @amount_hash[(Date.today.year).to_s][mois]["all"]
    end
    @data_montants_n = @data_montants_n.each  {|item| item[1] = Money.new(item[1]).format.delete_prefix('€')}

    @data_ca_reel_n = [["january",[]],["february",[]],["march",[]],["april",[]],["may",[]],["june",[]],["july",[]],["august",[]],["september",[]],["october",[]],["november",[]],["december",[]]]
    ## A modifier
    @amount_hash[(Date.today.year).to_s].keys.each_with_index do |mois,index|
      @data_ca_reel_n[index][1] = Money.new(@amount_hash[(Date.today.year).to_s][mois]["Payée"]).format.delete_prefix('€')
    end
    @data_ca_reel_n_1 = [["january",[]],["february",[]],["march",[]],["april",[]],["may",[]],["june",[]],["july",[]],["august",[]],["september",[]],["october",[]],["november",[]],["december",[]]]
    ## A modifier
    @amount_hash[(Date.today.year-1).to_s].keys.each_with_index do |mois,index|
      @data_ca_reel_n_1[index][1] = Money.new(@amount_hash[(Date.today.year-1).to_s][mois]["Payée"]).format.delete_prefix('€')
    end

    @data_commandes = [
      {name:"Ouverture de compte",
        data: @data_ouvertures_n},
      {name:"Réassort",
        data: @reassort_datas},
      {name:"Montant des commandes",
        data: @data_montants_n},
      {name:"CA réel 2024",
        data: @data_ca_reel_n},
      {name:"CA réel 2023",
        data: @data_ca_reel_n_1}
    ]

    ## Clients n'ayant pas commandé

    ## Fin
    @amount_hash = @amount_hash.transform_values do |value|   value.presence || 0 end
  end

  def filter_up

    if params[:cat] == "prospect"
      #@prospects = Prospect.all.where(commercial_id: @commercial.id)
      #@prospects = @prospects.order("#{params[:filtre]} ASC")
      redirect_to prospects_crm_index_path(current_commercial,filter: params[:filtre],order:"asc" )
      #redirect_back(fallback_location: { action: url[:action], params: {prospects:@prospects}})
    elsif params[:cat] == "customer"
      redirect_to clients_crm_index_path(current_commercial,filter: params[:filtre],order:"asc" )
      #@clients = Customer.all.where(commercial_id: @commercial.id)

    elsif params[:cat] == "order"
      fail
    end
  end

  def filter_down
    if params[:cat] == "prospect"
      #@prospects = Prospect.all.where(commercial_id: @commercial.id)
      #@prospects = @prospects.order("#{params[:filtre]} ASC")
      redirect_to prospects_crm_index_path(current_commercial,filter: params[:filtre],order:"desc" )
      #redirect_back(fallback_location: { action: url[:action], params: {prospects:@prospects}})
    elsif params[:cat] == "customer"
      redirect_to clients_crm_index_path(current_commercial,filter: params[:filtre],order:"desc" )

    elsif params[:cat] == "order"
      fail
    end
  end

  def prospection
  end

  def request_prospection
    country = params[:datas][:country]
    cp = params[:datas][:cp]
    address = params[:datas][:address]
    town = params[:datas][:town]
    category = (params[:datas][:category]).parameterize(separator: '_')
    radius = (params[:datas][:rayon].to_i)*1000
    full_address = [address, cp, town, country].compact.join(', ')
    results = Geocoder.search(full_address)
    lat = results.first.coordinates[0]
    lng = results.first.coordinates[1]
    coordinates = [lat,lng].compact.join(',')
    #{:location=>"46.603354, 1.8883335", :radius=>20000, :type=>"beauty_salon", :key=>"AIzaSyC74ObwjB-HWFHBjvCyZUpgduKw-uQQ7a4"}
    results = get_prospects(coordinates,radius,category)
    fail
    #test
  end

  private
  def prospect_params
    params.require(:prospect).permit(:lastname,:firstname,:email,:source,:institut,:cp,:country,:town,:tel,:date_prospect,:statut,:commercial_id,:comment)
  end

  def customer_params
    params.require(:customer).permit(:email, :password,:lastname,:firstname,:institut,:cp,:country,:town,:tel,:code_client,:payment_mode,:conditions_commerciales,:actif,:commercial_id,:prospect_id)
  end

  def institut_params
    params.require(:institut).permit(:name,:description,:tel,:address,:cp,:city,:country,:latitude,:longitude,:category,:fb,:ig,:tik_tok,:rdv,:mess_promo,:region,:customer_id,horaires:{},photos: [])
  end
end
