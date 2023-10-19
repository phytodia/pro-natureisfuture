class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(params[:profile])
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
    params.require(:profile).permit(:firstname,:lastname,:role,:address,:city,:cp,:country,:tel)
  end
end
