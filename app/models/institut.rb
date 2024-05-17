class Institut < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :customer
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?
  after_initialize :init_horaires
  has_many_attached :photos
  has_one_attached :promo_photo
  has_one :carte, dependent: :destroy
  has_rich_text :content
  has_many :message_instituts, dependent: :destroy
  has_one :stock_institut, dependent: :destroy

  CATEGORIES = ["institut de beauté","day spa"]
  TELS = {
    "FR": "+33",
    "BE": "+32",
    "LU": "+352",
    "CH": "+41",
    "AD": "+376",
    "MC": "+377"
  }

  def full_address
    [address, cp, city, country].compact.join(', ')
  end

  def init_horaires
    self.horaires ||= { lundi: {am_1:"",am_2:"",pm_1:"",pm_2:""},mardi: {am_1:"",am_2:"",pm_1:"",pm_2:""},mercredi: {am_1:"",am_2:"",pm_1:"",pm_2:""},jeudi: {am_1:"",am_2:"",pm_1:"",pm_2:""},vendredi: {am_1:"",am_2:"",pm_1:"",pm_2:""},samedi: {am_1:"",am_2:"",pm_1:"",pm_2:""},dimanche: {am_1:"",am_2:"",pm_1:"",pm_2:""}}.to_json
  end
end
