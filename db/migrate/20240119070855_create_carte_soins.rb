class CreateCarteSoins < ActiveRecord::Migration[7.0]
  def change
    create_table :carte_soins do |t|
      t.references :carte, null: false, foreign_key: true
      t.references :soin, null: false, foreign_key: true
      t.references :custom_soin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
