class CreateCustomSoins < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_soins do |t|
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
