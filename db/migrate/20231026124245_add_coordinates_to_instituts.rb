class AddCoordinatesToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :latitude, :float
    add_column :instituts, :longitude, :float
  end
end
