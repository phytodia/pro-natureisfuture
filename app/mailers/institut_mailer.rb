class InstitutMailer < ApplicationMailer

  def nouvelle_demande
    mail(to:"th@phytodia.com", subject:"Nouvelle demande de rendez-vous pour un soin",from:"no-reply@pro.natureisfuture.fr")
  end
end
