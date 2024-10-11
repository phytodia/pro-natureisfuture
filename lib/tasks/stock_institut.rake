namespace :stock_institut do
  desc "TODO"
  task reinitialize: :environment do
    puts "launch reinitialize stock institut taks"
    PdtStockItem.destroy_all
    StockInstitut.destroy_all
    produits_ids = Product.where(public:true).pluck(:id).uniq

    instituts_ids = Institut.all.pluck(:id).uniq
    instituts_ids.each do |institut_id|
      stock_institut = StockInstitut.create(institut_id: institut_id)
      produits_ids.each do |pdt_id|
        # On s'assure qu'un seul produit est ajouté pour chaque StockInstitut
        unless PdtStockItem.exists?(stock_institut_id: stock_institut.id, product_id: pdt_id)
          PdtStockItem.create(stock_institut_id: stock_institut.id, product_id: pdt_id, quantity: 0)
        end
      end
      sleep 1
    end

    puts "Stock créé avec succès"
  end

end
