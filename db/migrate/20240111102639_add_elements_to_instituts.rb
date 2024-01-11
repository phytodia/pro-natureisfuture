class AddElementsToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :fb, :string
    add_column :instituts, :ig, :string
    add_column :instituts, :tik_tok, :string
    add_column :instituts, :rdv, :string
    add_column :instituts, :mess_promo, :string
  end
end
