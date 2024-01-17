class CreateProductSoinItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_soin_items do |t|
      t.integer :ml
      t.references :product, null: false, foreign_key: true
      t.references :soin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
