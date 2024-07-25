class Slide < ApplicationRecord
  belongs_to :slider_home
  has_many_attached :photos
end
