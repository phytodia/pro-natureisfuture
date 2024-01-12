class AddDescriptionToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :description, :text
  end
end
