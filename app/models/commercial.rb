class Commercial < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def full_name
    "#{firstname} #{lastname}"
  end

  def customers
    Customer.where(commercial_id:self.id)
  end

  def customers_not_commanded
    @customers_not_commanded =  {
      "6 mois"=>[],
      "9 mois"=>[],
      "12 mois et plus"=>[]
    }
    self.customers.each do |customer|
      if !customer.orders.blank?
        last_order = customer.orders.order(custom_date: :asc).last
        ecart_day = ((Time.current - last_order.custom_date))/86400 #3600 * 24
        if ecart_day >= 180 && ecart_day < 270 # 6 mois
          @customers_not_commanded["6 mois"].push(customer.id)
        elsif ecart_day >= 270 && ecart_day < 365 # 9 mois
          @customers_not_commanded["9 mois"].push(customer.id)
        elsif ecart_day >= 365 # 12 mois et plus
          @customers_not_commanded["12 mois et plus"].push(customer.id)
        end
      end
    end
    ## return customers id in hash
    return @customers_not_commanded
  end

  def amount_hash

  end

end
