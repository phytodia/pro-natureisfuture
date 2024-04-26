class AddPlaceIdToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :place_id,:string
  end
end
