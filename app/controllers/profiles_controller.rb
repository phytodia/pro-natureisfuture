class ProfilesController < ApplicationController

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    #@user = User.new
    @profile = Profile.new
    #@profile = Profile.new
    #@profile.build_user
  end

  def create
    new_user = User.new(emai:params[:profile][:user][:email],password:params[:profile][:user][:password])
    fail
    @profile = Profile.new(params[:profile])
    fail
    @profile.save
    redirect_to profile_path(@profile)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def profile_param
    params.require(:profile).permit(:firstname,:lastname,:role,:address,:city,:cp,:country,:tel,users_attributes: [:email,:password])
  end
end
