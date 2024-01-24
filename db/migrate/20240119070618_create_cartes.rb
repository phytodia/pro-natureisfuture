class CreateCartes < ActiveRecord::Migration[7.0]
  def change
    create_table :cartes do |t|
      t.references :institut, null: false, foreign_key: true

      t.timestamps
    end
  end
end
