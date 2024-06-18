class PageMailer < ApplicationMailer

  def contact
    mail(to:"commercial@natureisfuture.fr",subject:"NIF PRO - Nouvelle soumission")
  end

  def devenir_partenaire
    attachments['presentation-nature-is-future.pdf'] = File.read("./public/presentation-nature-is-future.pdf")
    mail(to:"th@phytodia.com", subject:"Votre documentation Nature is Future")
  end
end
