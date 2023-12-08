class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :actions, array: true
      t.string :gamme
      t.string :labels, array: true
      t.string :types_peau, array: true
      t.string :texture
      t.string :utilisation
      t.string :contenances, array: true
      t.string :yuka_appreciation
      t.text :product_plus
      t.text :product_conseil
      t.text :product_gestes
      t.string :ingredients, array: true

      t.timestamps
    end
  end
end
