class Institut < ApplicationRecord
  belongs_to :customer
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?
  after_initialize :init_horaires

  def full_address
    [address, cp, city, country].compact.join(', ')
  end

  def init_horaires
    self.horaires ||= { lundi: {am_1:"",am_2:"",pm_1:"",pm_2:""},mardi: {am_1:"",am_2:"",pm_1:"",pm_2:""},mercredi: {am_1:"",am_2:"",pm_1:"",pm_2:""},jeudi: {am_1:"",am_2:"",pm_1:"",pm_2:""},vendredi: {am_1:"",am_2:"",pm_1:"",pm_2:""},samedi: {am_1:"",am_2:"",pm_1:"",pm_2:""},dimanche: {am_1:"",am_2:"",pm_1:"",pm_2:""}}.to_json
  end
end
