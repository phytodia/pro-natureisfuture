class TeamMembersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @team_member = TeamMember.new
  end

  def create
    new_user = User.new(email:params["team_member"]["user"]["email"],password:params["team_member"]["user"]["password"])
    new_user.save!
    @team_member = TeamMember.new(team_member_params)
    @team_member.user = new_user
    @team_member.save
    redirect_to :root
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def team_member_params
    params.require(:team_member).permit(:firstname,:lastname,:tel,:role,users_attributes: [:email,:password])
  end


end
