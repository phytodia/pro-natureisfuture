class PdtStockItem < ApplicationRecord
  belongs_to :stock_institut
  belongs_to :product
end
