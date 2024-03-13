class InstitutMailer < ApplicationMailer

  def nouvelle_demande
    ## Check destinataire
    mail(to:params[:gerant_email], subject:"Nouvelle demande de rendez-vous pour un soin")
  end
end
