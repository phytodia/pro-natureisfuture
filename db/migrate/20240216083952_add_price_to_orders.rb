class AddPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_monetize :orders, :amount_ht,currency: { present: false }
    add_monetize :orders, :amount_ttc,currency: { present: false }
    add_monetize :orders, :tva,currency: { present: false }
    add_monetize :orders, :reduction_ht,currency: { present: false }
  end
end
