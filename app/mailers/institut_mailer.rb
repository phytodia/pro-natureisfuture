class InstitutMailer < ApplicationMailer
  def nouvelle_demande
    @institut = params[:institut]
    @institut_email = @institut.customer.email
    @lastname = @lastname
    @firstname = @fistname
    @tel = @tel
    @date_soin = @date
    @soin = @soin
    @message = @message
    @email_client = @email_client
    @rgpd = @rgpd

    mail(to: @institut_email, subject:"Nouvelle demande de rendez-vous pour un soin")
  end
end
