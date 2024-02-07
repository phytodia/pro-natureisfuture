class Product < ApplicationRecord
  has_many_attached :photos
  has_many :product_soin_items
  has_many :soins, through: :product_soin_items
  monetize :price_ht_cents

  extend FriendlyId
  friendly_id :name, use: :slugged

  PREOCCUPATIONS = ["hydratation","nutrition","ride","fermeté","nettoyage","imperfection","sensibilité","tiraillement","éclat","minceur"]
  TYPES_PRODUIT = ["crème","sérum","contour des yeux","masque","gommage","nettoyant","lotion","huile"]

  scope :creme, -> { where("'crème' = ANY (types_produit)") }
  scope :serum, -> { where("'sérum' = ANY (types_produit)") }
  scope :contour, -> { where("'contour des yeux' = ANY (types_produit)") }
  scope :masque, -> { where("'masque' = ANY (types_produit)") }
  scope :gommage, -> { where("'gommage' = ANY (types_produit)") }
  scope :nettoyant, -> { where("'nettoyant' = ANY (types_produit)") }
  #serialize :actions, Array
  #serialize :labels, Array
  #serialize :types_peau, Array
  #serialize :contenances, Array
  #serialize :ingredients, Array
end
