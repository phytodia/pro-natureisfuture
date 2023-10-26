class CreateInstituts < ActiveRecord::Migration[7.0]
  def change
    create_table :instituts do |t|
      t.string :name
      t.string :tel
      t.string :address
      t.string :cp
      t.string :city
      t.string :country
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
