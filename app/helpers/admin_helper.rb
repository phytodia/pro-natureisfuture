module AdminHelper

  def self.csv_to_customers
    #Pour appeler le helper depuis rails c : AdminHelper.csv_to_customers
    require "csv"
    filepath = "db/data/clients_nif.csv"
    #table = CSV.parse(File.read(filepath), headers: true)
    CSV.foreach((filepath), headers: true, col_sep: ";") do |row|
      custom = Customer.new(email:row[4],password:row[5],lastname:row[0],firstname:row[1],commercial_id:row[2],code_client:row[6])
      if custom.valid?
        custom.save!
      else
        custom.errors
      end
    end
  end
end
