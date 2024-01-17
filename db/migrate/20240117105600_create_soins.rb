class CreateSoins < ActiveRecord::Migration[7.0]
  def change
    create_table :soins do |t|
      t.string :name
      t.string :category
      t.text :description
      t.string :estimated_time

      t.timestamps
    end
  end
end
