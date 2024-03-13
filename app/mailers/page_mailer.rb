class PageMailer < ApplicationMailer

  def contact
    mail(to:"contact@natureisfuture.fr",subject:"NIF PRO - Nouvelle soumission")
  end
end
