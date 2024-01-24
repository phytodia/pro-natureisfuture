class Product < ApplicationRecord
  has_many_attached :photos
  has_many :product_soin_items
  has_many :soins, through: :product_soin_items
  monetize :price_ht_cents

  PREOCCUPATIONS = ["hydratation","nutrition","ride","fermeté","nettoyage","imperfection","sensibilité","tiraillement","éclat","minceur"]
  TYPES_PRODUIT = ["crème","sérum","contour des yeux","masque","gommage","nettoyant","lotion","huile"]
  #serialize :actions, Array
  #serialize :labels, Array
  #serialize :types_peau, Array
  #serialize :contenances, Array
  #serialize :ingredients, Array
end
