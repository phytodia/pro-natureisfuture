class PhotothequeEspaceProsController < ApplicationController
  def index
    @phototheque = PhotothequeEspacePro.last
  end
  def add_file
    @phototheque = PhotothequeEspacePro.last
  end

  def save_file
    @phototheque = PhotothequeEspacePro.last
    @phototheque.files.attach(params["phototheque_espace_pro"]["file"])
    redirect_to phototheque_path
  end

  def delete_file
    PhotothequeEspacePro.last.files.find(params[:id]).purge
    redirect_to phototheque_path
    #institut = Institut.friendly.find(params[:institut])

    #institut.photos.where(id:params[:photo]).purge
    #redirect_to edit_institut_crm_index_path(institut)
  end

  #def download_file(file)
  #  require "open-uri"
  #  url = file.url
  #  data = open(url).read
  #  send_data
  #end
end
