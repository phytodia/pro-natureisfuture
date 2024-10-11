class AddElementsToPhotothequeEspaceProFolder < ActiveRecord::Migration[7.1]
  def change
    add_column :phototheque_espace_pro_folders, :name, :string
    add_column :phototheque_espace_pro_folders, :public, :boolean, default: true
  end
end
