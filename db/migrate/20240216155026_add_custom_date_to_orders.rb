class AddCustomDateToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :custom_date, :datetime
  end
end
