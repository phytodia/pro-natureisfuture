class AddOthersSoinsToCarte < ActiveRecord::Migration[7.0]
  def change
    add_column :cartes, :others, :text, array: true, default: []
  end
end
