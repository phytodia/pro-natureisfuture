class PageMailer < ApplicationMailer

  def contact
    mail(to:"commercial@natureisfuture.fr",subject:"NIF PRO - Nouvelle soumission")
  end
end
