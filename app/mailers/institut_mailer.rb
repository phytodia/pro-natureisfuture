class InstitutMailer < ApplicationMailer

  def nouvelle_demande
    ## Check destinataire
    mail(to:"hunckler.thomas@hotmail.fr", subject:"Nouvelle demande de rendez-vous pour un soin")
  end
end
