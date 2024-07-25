class SlideItem < ApplicationRecord
  belongs_to :slider_home
  has_one_attached :photo
end
