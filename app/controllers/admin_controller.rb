class AdminController < ApplicationController
  before_action :authenticate_user!, :check_admin

  def index
    @profiles = Profile.all
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

  def destroy
  end

  def customers
    @customers = Customer.all
  end
  def customer
    @customer = Customer.find(params[:id])
  end

  def admin_soins
    @soins = Soin.all
  end

  def cours
    @cours = Course.all
  end

  def instituts
    #ids_instituts = current_customer.instituts.ids
    @instituts_views = Ahoy::Event.where(name: "institut_view").group_by {|event| event.properties['page_name']}
    #@institut_views = @instituts_views.group_by {|event| event.properties['page_name']}
    #@visits = []
    #ids_instituts.each do |id|
    #  @visits << @datas_first.where("properties @> ?", { institut_id: id }.to_json)
    #end
  end

  private
  def check_admin
    if current_user.profile.role != "admin"
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cet espace"
    else
    end
  end

end
