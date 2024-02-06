class InstitutMailer < ApplicationMailer
  def nouvelle_demande
    #@institut =
    #@client =
    mail(to: @institut.email, subject:"Nouvelle demande de rendez-vous pour un soin")
  end
end
