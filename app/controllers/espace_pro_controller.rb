class EspaceProController < ApplicationController
  before_action :authenticate_user!, :check_profile

  def index

  end

  def show

  end
  private
  def check_profile
    @profile = Profile.find(current_user.profile.id)
    #redirect_to espace_pro_index_path
  end
end
