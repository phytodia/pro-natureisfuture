class CreateProspects < ActiveRecord::Migration[7.0]
  def change
    create_table :prospects do |t|
      t.string :lastname
      t.string :firstname
      t.string :email
      t.string :source
      t.string :institut
      t.string :cp
      t.string :country
      t.string :town
      t.string :tel
      t.datetime :date_prospect
      t.string :statut, default:"nouveau"
      t.string :commercial
      t.text :comment

      t.timestamps
    end
  end
end
