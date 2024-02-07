class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home
  #add_breadcrumb "Home", :root_path
  def home
    @page_title = "Nature is Future Pro | Cosmétiques pour institut de beauté, Bio et naturels"
    @page_description = "Member login page."
  end
  def contact
  end
end
