class CreatePdtStockItems < ActiveRecord::Migration[7.0]
  def change
    create_table :pdt_stock_items do |t|
      t.references :stock_institut, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
