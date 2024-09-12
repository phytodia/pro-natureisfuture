module StockInstitutsHelper

  def self.reinitialize_stock_institut
    #Pour appeler le helper depuis rails c : StockInstitutsHelper.reinitialize_stock_institut
    PdtStockItem.destroy_all
    StockInstitut.all.each do |stock|
      stock.init_stock
      puts "stock crée pour #{stock.institut}"
      sleep 2
    end
  end
end
