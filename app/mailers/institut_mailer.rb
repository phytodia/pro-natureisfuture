class InstitutMailer < ApplicationMailer

  def nouvelle_demande
    mail(to:"hunckler.thomas@hotmail.fr", subject:"Nouvelle demande de rendez-vous pour un soin")
  end
end
