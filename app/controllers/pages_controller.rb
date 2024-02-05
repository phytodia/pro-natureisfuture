class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home
  #add_breadcrumb "Home", :root_path
  def home
  end
  def contact
  end
end
