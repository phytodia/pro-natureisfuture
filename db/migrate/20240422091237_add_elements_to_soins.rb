class AddElementsToSoins < ActiveRecord::Migration[7.0]
  def change
    add_column :soins, :types_peau, :text,array: true, default: []
    add_column :soins, :benefices, :text,array: true, default: []
    add_column :soins, :products_associated, :text,array: true, default: []
    add_column :soins, :pregnant_adapted, :boolean, default: false
  end
end
