class CreateProductCustomSoinItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_custom_soin_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :custom_soin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
