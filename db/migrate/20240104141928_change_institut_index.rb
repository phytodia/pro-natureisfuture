class ChangeInstitutIndex < ActiveRecord::Migration[7.0]
  def change
    remove_reference :instituts, :profile, index: true, foreign_key: true
    add_reference :instituts, :customer, index: true, foreign_key: true
  end
end
