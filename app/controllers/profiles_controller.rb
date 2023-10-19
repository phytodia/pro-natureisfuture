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
    @commerciaux = TeamMember.all.where(role:"commercial")
    #@profile = Profile.new
    #@profile.build_user
  end

  def create
    new_user = User.new(email:params[:profile][:user][:email],password:params[:profile][:user][:password])
    new_user.save!
    @profile = Profile.new(profile_params)
    commercial = TeamMember.find_by(firstname:params[:profile][:team_member])
    @profile.team_member_id = commercial.id
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
  def profile_params
    params.require(:profile).permit(:firstname,:lastname,:role,:address,:city,:cp,:country,:tel,:team_member_id,users_attributes: [:email,:password])
  end
end
