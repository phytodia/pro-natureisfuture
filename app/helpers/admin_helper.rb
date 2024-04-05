module AdminHelper

  def self.csv_to_customers
    #Pour appeler le helper depuis rails c : AdminHelper.csv_to_customers
    require "csv"
    filepath = "db/data/clients_nif.csv"
    #table = CSV.parse(File.read(filepath), headers: true)
    CSV.foreach((filepath), headers: true, col_sep: ";") do |row|
      #puts "row 0#{row[0]}"
      #puts "row 1#{row[1]}"
      #puts "row 2#{row[2]}"
      #puts "row 3#{row[3]}"
      #puts "row 4#{row[4]}"
      #puts "row 5#{row[5]}"
      #puts "row 6#{row[6]}"
      custom = Customer.new(email:row[4], password:row[5], lastname:row[0], firstname:row[1], commercial_id:row[2],institut:row[3], code_client:row[6])
      if custom.valid?
        custom.save!
      else
        custom.errors
      end
    end
  end
end
