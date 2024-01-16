class InstitutsController < ApplicationController
  def index
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
    @institut = Institut.find(params[:id])
    @flat = @institut
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
    fail
  end

  private
  def institut_params
    params.require(:institut).permit(:name,:address,:city,:cp,:latitude,:longitude, :customer_id,photos: [])
  end
end
