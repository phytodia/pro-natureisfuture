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

  private
  def check_admin
    if current_user.profile.role != "admin"
      redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cet espace"
    else
    end
  end

end
