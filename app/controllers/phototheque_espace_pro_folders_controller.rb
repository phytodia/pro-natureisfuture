class PhotothequeEspaceProFoldersController < ApplicationController
  def new
    @folder = PhotothequeEspaceProFolder.new
    @phototheque = PhotothequeEspacePro.last
  end

  def create
    @folder = PhotothequeEspaceProFolder.new(folder_params)
    @folder.save
    redirect_to phototheque_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
  def folder_params
    params.require(:phototheque_espace_pro_folder).permit(:name,:phototheque_espace_pro_id,:public)
  end
end
