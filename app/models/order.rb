class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products
  has_many :products, through: :order_products
  monetize :amount_ht_cents
  monetize :reduction_ht_cents
  monetize :amount_ttc_cents
  monetize :tva_cents
  accepts_nested_attributes_for :order_products
  STATES = ["En attente de paiement","Payée"]
  PAYMENTMODES = ["Virement bancaire","Stripe/CB","Paypal"]
end
