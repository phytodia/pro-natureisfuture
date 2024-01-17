class Product < ApplicationRecord
  has_many_attached :photos
  has_many :product_soin_items
  #serialize :actions, Array
  #serialize :labels, Array
  #serialize :types_peau, Array
  #serialize :contenances, Array
  #serialize :ingredients, Array
end
