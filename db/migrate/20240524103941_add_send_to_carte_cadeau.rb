class AddSendToCarteCadeau < ActiveRecord::Migration[7.0]
  def change
    add_column :carte_cadeaus, :send, :boolean, default: false
  end
end
