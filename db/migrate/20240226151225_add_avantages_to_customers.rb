class AddAvantagesToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :avantages, :json, default: {}
  end
end
