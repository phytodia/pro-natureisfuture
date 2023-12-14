class Product < ApplicationRecord
  has_many_attached :photos
  #serialize :actions, Array
  #serialize :labels, Array
  #serialize :types_peau, Array
  #serialize :contenances, Array
  #serialize :ingredients, Array
end
