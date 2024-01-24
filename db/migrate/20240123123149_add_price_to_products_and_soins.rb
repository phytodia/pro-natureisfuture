class AddPriceToProductsAndSoins < ActiveRecord::Migration[7.0]
  def change
    add_monetize :products, :price, currency: { present: false }
    add_monetize :soins, :price, currency: { present: false }
    add_monetize :custom_soins, :price, currency: { present: false }
    add_monetize :carte_soins, :price, currency: { present: false }
  end
end
