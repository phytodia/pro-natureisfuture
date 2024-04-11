module AdminHelper

  def self.csv_to_customers
    #Pour appeler le helper depuis rails c : AdminHelper.csv_to_customers
    require "csv"
    filepath = "db/data/clients_nif.csv"
    #table = CSV.parse(File.read(filepath), headers: true)
    CSV.foreach((filepath), headers: true, encoding:'iso-8859-1:utf-8', col_sep: ";") do |row|
      #puts "row 0#{row[0]}"
      #puts "row 1#{row[1]}"
      #puts "row 2#{row[2]}"
      #puts "row 3#{row[3]}"
      #puts "row 4#{row[4]}"
      #puts "row 5#{row[5]}"
      #puts "row 6#{row[6]}"
      puts "nouveau client"
      custom = Customer.new(email:row[4], password:row[5], lastname:row[0], firstname:row[1], commercial_id:row[2],institut:row[3], code_client:row[6])
      if custom.valid?
        puts "client crée"
        custom.save!
      else
        puts "erreur"
        custom.errors
      end
    end
  end

  def self.csv_to_cmd
    require "csv"
    filepath = "db/data/cmd_nif.csv"
    CSV.foreach((filepath), headers: true, col_sep: ";") do |row|
      #puts row[0] #cmd presta
      #puts row[2] #email
      #puts row[3] #amount_ht_cents
      #puts row[4] #year
      #puts row[5] #month
      #puts row[6] #day
      #puts "---"

      custom = Customer.find_by(email:row[2].to_s)
      customers_nil = []
      if !custom.nil?
        amount = row[3].to_i / 1.2
        date = Date.new(row[4].to_i,row[5].to_i,row[6].to_i)
        order = Order.new(customer_id:custom.id, prestashop_reference:row[0],amount_ht_cents:amount,custom_date:date)
        if order.valid?
          order.save!
        else
          order.errors
        end
      else
        customers_nil << custom
      end
    end
  end
end
