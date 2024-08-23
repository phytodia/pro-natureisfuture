class CreatePhotothequeEspacePros < ActiveRecord::Migration[7.0]
  def change
    create_table :phototheque_espace_pros do |t|

      t.timestamps
    end
  end
end
