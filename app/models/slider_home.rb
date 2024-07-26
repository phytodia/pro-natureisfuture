class SliderHome < ApplicationRecord
  has_many :slide_items
  accepts_nested_attributes_for :slide_items
end
