class Order < ApplicationRecord
  belongs_to :customer
  monetize :amount_ht_cents
  monetize :reduction_ht_cents
  monetize :amount_ttc_cents
  monetize :tva_cents
end
