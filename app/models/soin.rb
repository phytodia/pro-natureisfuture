class Soin < ApplicationRecord
  has_one_attached :photo
  has_many :product_soin_items
  has_many :products, through: :product_soin_items
  has_many :cartes, through: :carte_soins
  monetize :price_ttc_cents
end
