class AddElementsToCarteSoin < ActiveRecord::Migration[7.0]
  def change
    add_column :carte_soins, :estimated_time, :string
  end
end
