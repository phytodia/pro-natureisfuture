class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: :home
  add_breadcrumb "Home", :root_path
  def home
    @page_title = "Nature is Future Pro | Cosmétiques pour institut de beauté, Bio et naturels"
    @page_description = "Member login page."

    @reviews = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_avis.yml")
    @textes = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_textes.yml")

    @slider = SliderHome.first

    @best_sellers = Product.first(6)

    instituts_partenaires = YAML.load_file("#{Rails.root.to_s}/db/yaml/home_partenaires.yml")
    instituts_ids = instituts_partenaires.values.map { |hash| hash.values }.flatten
    @instituts = []
    if @instituts != []
      instituts_ids.each {|id| @instituts << Institut.find(id)}
    end

    render layout: "home"
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

  def devenir_partenaire
  end

  def region
    @region = params[:region]
    add_breadcrumb "Instituts de beauté".upcase.html_safe, instituts_path
    add_breadcrumb "<strong>#{@region.upcase}</strong>".html_safe

    @page_title = "Instituts de beauté en #{@region} | Nature is Future Pro"
    @page_description = "Les instituts de beauté bio présents dans la région #{@region}"

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

  def send_partenaire
    elements = params[:contact_partenaire]
    lastname = elements[:lastname]
    firstname = elements[:firstname]
    email = elements[:email]
    tel = elements[:tel]
    cp = elements[:cp]
    ville = elements[:ville]
    institut = elements[:institut]
    rgpd = elements[:rgpd]
    prospect = Prospect.new(lastname:lastname,firstname:firstname,email:email,institut:institut,cp:cp,town:ville,tel:tel,date_prospect:Time.now)
    if prospect.save
      PageMailer.with(email:email).devenir_partenaire.deliver_now
      redirect_to devenir_partenaire_path,notice: "Votre documentation vient de vous être envoyée par mail"
    else
      redirect_to devenir_partenaire_path,notice: "Il y a eu une erreur dans l'envoi, veuillez réessayer"
    end

  end

  def formations
    add_breadcrumb "<strong>FORMATIONS</strong>".upcase.html_safe
    @courses = Course.all
  end
end
