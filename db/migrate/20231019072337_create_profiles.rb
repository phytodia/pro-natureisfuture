class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :role
      t.string :tel
      t.string :address
      t.string :city
      t.string :cp
      t.string :country
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
