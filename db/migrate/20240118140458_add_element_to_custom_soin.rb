class AddElementToCustomSoin < ActiveRecord::Migration[7.0]
  def change
    add_column :custom_soins, :name, :string
    add_column :custom_soins, :description, :text
    add_column :custom_soins, :estimated_time, :string
    add_column :custom_soins, :category, :string
    add_column :product_custom_soin_items, :ml, :integer
  end
end
