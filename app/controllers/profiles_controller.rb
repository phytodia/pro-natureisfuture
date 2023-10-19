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
    new_user = User.new(email:params[:profile][:user][:email],password:params[:profile][:user][:password])
    new_user.save!
    @profile = Profile.new(
      lastname: params[:profile][:lastname],
      firstname: params[:profile][:firstname],
      role: params[:profile][:role],
      address: params[:profile][:address],
      city: params[:profile][:city],
      cp: params[:profile][:cp],
      tel: params[:profile][:tel],
      country: params[:profile][:country],
    )
    @profile.user = new_user
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
