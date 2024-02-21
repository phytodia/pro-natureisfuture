class AddStateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :state, :string
    add_column :orders, :payment_mode, :string
  end
end
