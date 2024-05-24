class CarteCadeau < ApplicationRecord
  belongs_to :institut
  monetize :price_cents
end
