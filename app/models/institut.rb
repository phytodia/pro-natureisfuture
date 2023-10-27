class Institut < ApplicationRecord
  belongs_to :profile
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
