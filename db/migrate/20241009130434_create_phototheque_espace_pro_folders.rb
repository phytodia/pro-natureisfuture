class CreatePhotothequeEspaceProFolders < ActiveRecord::Migration[7.1]
  def change
    create_table :phototheque_espace_pro_folders do |t|
      t.references :phototheque_espace_pro, null: false, foreign_key: true

      t.timestamps
    end
  end
end
