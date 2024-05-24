class InstitutMailer < ApplicationMailer

  def nouvelle_demande
    ## Check destinataire
    mail(to:params[:gerant_email], subject:"Nouvelle demande de rendez-vous pour un soin")
  end

  def send_cheque
    mail(to: 'hunckler.thomas@hotmail.fr', subject:"Votre bon cadeau")
  end
end
