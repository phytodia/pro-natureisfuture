class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
  monetize :amount_ht_cents
end
