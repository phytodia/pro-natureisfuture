class StockInstitut < ApplicationRecord
  belongs_to :institut
  has_many :pdt_stock_items
end
