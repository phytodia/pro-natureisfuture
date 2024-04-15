class ChangeStatusInCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :status
    add_column :customers, :actif, :boolean, default:true
  end
end
