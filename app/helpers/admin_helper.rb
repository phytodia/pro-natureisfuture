module AdminHelper

  def self.csv_to_customers
    require "csv"
    filepath = "db/data/clients_nif.csv"
    #table = CSV.parse(File.read(filepath), headers: true)
    CSV.foreach((filepath), headers: true, col_sep: ";") do |row|
      puts "lastname :#{row[0]}, firstname: #{row[1]}"
      puts "--"
    end
  end
end
