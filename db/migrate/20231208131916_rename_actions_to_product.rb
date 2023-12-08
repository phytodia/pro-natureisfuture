class RenameActionsToProduct < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :actions,:actions_product
  end
end
