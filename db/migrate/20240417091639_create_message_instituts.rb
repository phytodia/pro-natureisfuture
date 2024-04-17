class CreateMessageInstituts < ActiveRecord::Migration[7.0]
  def change
    create_table :message_instituts do |t|
      t.text :message
      t.string :destinataire
      t.string :email
      t.string :tel
      t.date :date
      t.references :institut, null: false, foreign_key: true

      t.timestamps
    end
  end
end
