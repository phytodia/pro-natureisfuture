class AddCategoryToPhotothequeEspaceProFolder < ActiveRecord::Migration[7.1]
  def change
    add_column :phototheque_espace_pro_folders, :category, :string
  end
end
