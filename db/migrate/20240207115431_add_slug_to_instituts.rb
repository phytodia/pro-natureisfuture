class AddSlugToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :slug, :string
    add_index :instituts, :slug, unique: true
    add_column :products, :slug, :string
    add_index :products, :slug, unique: true
    add_column :soins, :slug, :string
    add_index :soins, :slug, unique: true
  end
end
