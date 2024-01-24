class AddElementsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :preoccupations, :text,array: true, default: []
    add_column :products, :types_produit, :text,array: true, default: []
  end
end
