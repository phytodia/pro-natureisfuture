class AddElementsToSoinsBis < ActiveRecord::Migration[7.0]
  def change
    add_column :soins, :resultat, :string
    add_column :soins, :cible, :string
    add_column :soins, :protocole, :text
    add_column :soins, :actions_product,:text,array: true,default:[]
    add_column :soins, :labels,:text,array: true,default:[]
  end
end
