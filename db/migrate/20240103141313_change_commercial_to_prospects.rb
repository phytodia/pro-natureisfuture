class ChangeCommercialToProspects < ActiveRecord::Migration[7.0]
  def change
    remove_column :prospects, :commercial
    add_column :prospects, :commercial_id, :integer
  end
end
