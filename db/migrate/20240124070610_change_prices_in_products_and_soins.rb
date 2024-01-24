class ChangePricesInProductsAndSoins < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :price_cents
    add_monetize :products, :price_ht, currency: { present: false }

    remove_column :soins, :price_cents
    add_monetize :soins, :price_ttc, currency: { present: false }

    remove_column :custom_soins, :price_cents
    add_monetize :custom_soins, :price_ttc, currency: { present: false }

    remove_column :carte_soins, :price_cents
    add_monetize :carte_soins, :price_ttc, currency: { present: false }

  end
end
