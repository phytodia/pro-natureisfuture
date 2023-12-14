class AddContenancesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :contenance_revente, :integer
    add_column :products, :contenance_cabine, :integer
    remove_column :products, :contenances
  end
end
