class AddRegionToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :region, :string
  end
end
