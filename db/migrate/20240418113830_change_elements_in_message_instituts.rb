class ChangeElementsInMessageInstituts < ActiveRecord::Migration[7.0]
  def change
    rename_column :message_instituts, :destinataire, :expediteur
    add_column :message_instituts, :note, :text
    add_column :message_instituts, :hour, :time
  end
end
