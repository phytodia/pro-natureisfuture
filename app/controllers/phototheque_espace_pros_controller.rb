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
  end

  def delete_file
    fail
    file = PhotothequeEspacePro.last.files.find(params[:id])
    #institut = Institut.friendly.find(params[:institut])

    #institut.photos.where(id:params[:photo]).purge
    #redirect_to edit_institut_crm_index_path(institut)
  end
end
