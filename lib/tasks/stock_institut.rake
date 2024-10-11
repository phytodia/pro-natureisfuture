namespace :stock_institut do
  desc "Reinitialize stock institut"
  task reinitialize: :environment do
    StockInstitutsHelper.reinitialize_stock_institut
  end
end
