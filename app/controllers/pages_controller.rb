class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home
  #add_breadcrumb "Home", :root_path
  def home
    @page_title = "Nature is Future Pro | Cosmétiques pour institut de beauté, Bio et naturels"
    @page_description = "Member login page."
  end
  def contact
  end

  def donnees
  end
  def confidentialite
  end
  def cookies
  end
  def mentions
  end

  def region
    @region = params[:region]
    @villes = YAML.load_file("#{Rails.root.to_s}/db/yaml/villes_instituts.yml")[params[:region].capitalize]
  end

  def send_contact
    if params[:hidden_message].present?
      redirect_to request.referrer
    else
      contact = params[:contact]
      lastname = contact[:lastname]
      firstname = contact[:firstname]
      email = contact[:email]
      tel = contact[:tel]
      objet = contact[:objet]
      cp = contact[:cp]
      ville = contact[:ville]
      adresse = contact[:address]
      country = contact[:country]
      societe = contact[:societe]
      message = contact[:message]
      rgpd = contact[:rgpd]

      PageMailer.with(lastname:lastname,firstname:firstname,email:email,tel:tel,objet:objet,
        cp:cp,ville:ville,address:adresse,country:country,societe:societe,message:message,rgpd:rgpd
      ).contact.deliver_later
      puts "Message contact envoyé"
      redirect_to contact_path,notice: "Votre message a été envoyée avec succès"
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
