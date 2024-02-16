class AddPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_monetize :orders, :amount_ht
    add_monetize :orders, :amount_ttc
    add_monetize :orders, :tva
    add_monetize :orders, :reduction_ht
  end
end
