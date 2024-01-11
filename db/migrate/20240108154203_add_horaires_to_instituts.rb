class AddHorairesToInstituts < ActiveRecord::Migration[7.0]
  def change
    add_column :instituts, :horaires, :json, default: {}
  end
end
