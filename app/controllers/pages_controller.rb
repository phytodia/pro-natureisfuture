class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home
  #add_breadcrumb "Home", :root_path
  def home
    @page_title = "Nature is Future Pro | Cosmétiques pour institut de beauté, Bio et naturels"
    @page_description = "Member login page."
  end
  def contact
  end

  def send_contact
    if params[:hidden_message].present?
      redirect_to request.referrer
    else
      PageMailer.with(params:params[:contact]).contact.deliver_later
    end
  end

  def formations
    add_breadcrumb "Home".upcase, :root_path
    add_breadcrumb "<strong>FORMATIONS</strong>".upcase.html_safe
    @courses = Course.all
  end
  def partenaire

  end
end
