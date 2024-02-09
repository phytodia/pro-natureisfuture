class AddProductComplementairesToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :products_complementaires, :text,array: true, default: []
  end
end
