class RemoveNotNullConstraintFromCustomSoinIdInCarteSoins < ActiveRecord::Migration[7.0]
  def change
    change_column_null :carte_soins, :custom_soin_id, true
    change_column_null :carte_soins, :soin_id, true
  end
end
