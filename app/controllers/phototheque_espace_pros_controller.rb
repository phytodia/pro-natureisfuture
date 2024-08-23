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

    fail
  end

  def delete_file
  end
end
