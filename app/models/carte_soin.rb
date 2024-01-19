class CarteSoin < ApplicationRecord
  belongs_to :carte
  belongs_to :soin, optional: true
  belongs_to :custom_soin, optional: true
end
