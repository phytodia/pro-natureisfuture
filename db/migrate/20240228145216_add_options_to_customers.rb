class AddOptionsToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :code_client,:integer
    add_column :customers, :payment_mode, :string
    add_column :customers, :conditions_commerciales, :string
    add_column :customers, :status, :string
  end
end
