class CustomSoin < ApplicationRecord
  belongs_to :customer

  has_many :product_custom_soin_items
  has_many :products, through: :product_custom_soin_items
end
