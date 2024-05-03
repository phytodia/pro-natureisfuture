class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order,dependent: :destroy
  monetize :amount_ht_cents
end
