class StockInstitut < ApplicationRecord
  belongs_to :institut
  has_many :pdt_stock_items
  accepts_nested_attributes_for :pdt_stock_items
  after_create :init_stock

  def init_stock
    Product.all.where(public:true).each do |pdt|
      PdtStockItem.create(stock_institut_id: self.id,product_id: pdt.id,quantity:0)
    end
  end

end
