class AddCategoryToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :category, :string
  end
end
