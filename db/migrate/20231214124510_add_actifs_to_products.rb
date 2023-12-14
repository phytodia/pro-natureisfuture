class AddActifsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_actifs, :string, array: true
    add_column :products, :ean, :string
  end
end
