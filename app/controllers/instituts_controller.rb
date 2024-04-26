class InstitutsController < ApplicationController
  add_breadcrumb "Home".upcase, :root_path
  def index
    add_breadcrumb "<strong>Instituts de beauté</strong>".upcase.html_safe, instituts_path

    @page_title = "Instituts de beauté bio | Nature is Future Pro"
    @page_description = "Member login page."

    @instituts = Institut.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @instituts.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: flat}),
        marker_html: render_to_string(partial: "marker", locals: {flat: flat})
      }
  end
  end

  def show
    #@institut = Institut.find(params[:id])

    @institut = Institut.friendly.find(params[:id])

    add_breadcrumb "Instituts de beauté".upcase.html_safe, instituts_path
    add_breadcrumb "<strong>#{@institut.name.upcase}</strong>".html_safe, institut_path

    @page_title = "#{@institut.name} | Institut de beauté bio à #{@institut.city}"
    @page_description = "Member login page."

    @flat = @institut
    @soins = []
    if @institut.carte.present?
      @institut.carte.carte_soins.each do |soin|
        @soins << soin.soin if soin.soin_id != nil
        @soins << soin.custom_soin if soin.custom_soin != nil
      end
    end
    #require 'uri'

    #adresse = @institut.full_address
    #@adresse_encodee = "https://www.google.com/maps/place/#{URI.encode_www_form_component(adresse)}"

    @soins.sort_by(&:category)

    key_api = ENV["GOOGLE_MAP_API"]
    if @institut.place_id.present?
      place_id = @institut.place_id
      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=#{key_api}")
      data = response.parsed_response
      @rating = data["result"]["rating"]
      @reviews = data["result"]["reviews"]
    end

    #@soins << @institut.soins
    #@soins << @institut.custom_soins

    if @institut.category == "institut de beauté"
      @inst_structured_data_cat = "BeautySalon"
    elsif @institut.category == "day spa"
      @inst_structured_data_cat = "DaySpa"
    end
    @marker = [{
        lat: @flat.latitude,
        lng: @flat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {flat: @flat}),
        marker_html: render_to_string(partial: "marker", locals: {flat: @flat})
      }]
  #[{:lat=>49.6312952, :lng=>1.8207573, :info_window_html=>"<h2>Test etablissement</h2>\n<p>13 rue principale</p>\n", :marker_html=>"<img height=\"30\" width=\"30\" alt=\"Logo\" src=\"/assets/logo-ecf839a7ae9d8c3650270ea01ceb8d45ef0f33459d9b14df8e780355ddf57533.png\" />\n"}]
  end

  def new
    @institut = Institut.new
    @customer = Customer.find(params[:customer])
  end

  def create
    @institut = Institut.new(institut_params)
    @institut.save
    if @institut.save
      redirect_to admin_index_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def send_contact
    if params[:hidden_message].present?
      redirect_to request.referrer
    else
      # Logic to handle the form submission
      @institut = Institut.find(params[:contact][:institut_id])
      @institut_name = @institut.name
      @gerant_firstname = @institut.customer.firstname

      @gerant_email = @institut.customer.email
      @gerant_tel = @institut.customer.tel

      @lastname = params[:contact][:lastname]
      @firstname = params[:contact][:firstname]
      @email_client = params[:contact][:email]
      @tel_client = params[:contact][:tel]
      @date = params[:contact][:date]
      @message = params[:contact][:message]
      if params[:contact][:rgpd] == "1"
        @rgpd = true
      else
        @rgpd = false
      end
      @soin_select = params[:contact][:hidden_soin]
      InstitutMailer.with(gerant_email:@gerant_email,lastname:@lastname,firstname:@firstname,email_client:@email_client,tel_client:@tel_client,date:@date,message:@message,soin:@soin_select,rgpd:@rgpd, institut_name:@institut_name,gerant_firstname:@gerant_firstname,gerant_tel:@gerant_tel).nouvelle_demande.deliver_later
      puts "Email envoyé"

      message = MessageInstitut.new(
        institut_id:@institut.id, message:params[:contact][:message],expediteur:"#{@lastname} #{@firstname}",
        tel:@tel_client,date:@date,email:@email_client
      )
      message.save
      redirect_to institut_path(@institut),notice: "Votre message a été envoyée avec succès"

      #Email.create(email: params[:email])
      #redirect_to request.referrer
    end

  end

  private
  def institut_params
    params.require(:institut).permit(:name,:address,:city,:cp,:latitude,:longitude,:place_id,:customer_id,photos: [])
  end
end
