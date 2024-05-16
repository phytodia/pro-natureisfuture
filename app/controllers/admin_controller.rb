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

  private
  def check_admin
    if current_user.profile.role != "admin"
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cet espace"
    else
    end
  end

end
