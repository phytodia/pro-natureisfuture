class PhotothequeEspaceProFoldersController < ApplicationController
  def new
    @folder = PhotothequeEspaceProFolder.new
    @phototheque = PhotothequeEspacePro.last
  end

  def create
    @folder = PhotothequeEspaceProFolder.new(folder_params)
    @folder.save
    redirect_to mediatheque_path
  end

  def show
    @folder = PhotothequeEspaceProFolder.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def add_file
    @folder = PhotothequeEspaceProFolder.find(params[:id])
  end

  def save_file
    @folder = PhotothequeEspaceProFolder.find(params[:id])
    @folder.files.attach(params["phototheque_espace_pro_folder"]["file"])
    redirect_to phototheque_espace_pro_folder_path(@folder)
  end

  def delete_file
    @folder = PhotothequeEspaceProFolder.find(params[:folder])
    @folder.files.find(params[:id]).purge
    redirect_to phototheque_espace_pro_folder_path(@folder)
  end
  private
  def folder_params
    params.require(:phototheque_espace_pro_folder).permit(:name,:phototheque_espace_pro_id,:public)
  end
end
