class CreateCarteCadeaus < ActiveRecord::Migration[7.0]
  def change
    create_table :carte_cadeaus do |t|
      t.string :destinataire
      t.string :expediteur
      t.date :date_expiration
      t.text :message
      t.monetize :price
      t.references :institut, null: false, foreign_key: true

      t.timestamps
    end
  end
end
