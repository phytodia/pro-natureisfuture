class Institut < ApplicationRecord
  belongs_to :customer
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?
  after_initialize :init_horaires

  def full_address
    [address, cp, city, country].compact.join(', ')
  end

  def init_horaires
    self.horaires ||= { monday: {am_1:"",am_2:"",pm_1:"",pm_2:""},tuesday: {am_1:"",am_2:"",pm_1:"",pm_2:""},thursday: {am_1:"",am_2:"",pm_1:"",pm_2:""},friday: {am_1:"",am_2:"",pm_1:"",pm_2:""},saturday: {am_1:"",am_2:"",pm_1:"",pm_2:""},sunday: {am_1:"",am_2:"",pm_1:"",pm_2:""},monday: {am_1:"",am_2:"",pm_1:"",pm_2:""}}.to_json
  end
end
