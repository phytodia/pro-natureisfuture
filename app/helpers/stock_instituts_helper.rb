module StockInstitutsHelper

  def self.reinitialize_stock_institut
    #Pour appeler le helper depuis rails c : StockInstitutsHelper.reinitialize_stock_institut
    # Depuis Heroku : heroku run rails runner "StockInstitutsHelper.reinitialize_stock_institut"
    PdtStockItem.destroy_all
    StockInstitut.destroy_all
    produits_ids = Product.where(public:true).pluck(:id).uniq
    instituts_ids = Institut.all.pluck(:id).uniq
    instituts_ids.each do |institut_id|
      StockInstitut.create(institut_id:institut_id)
      sleep 1
    end
    StockInstitut.each do |stock|
      produits_ids.each do |pdt_id|
        PdtStockItem.create(stock_institut_id:stock.id,product_id:pdt_id,quantity:0)
      end
    end
    puts "stock crée"
  end
end
