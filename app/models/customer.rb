class Customer < ApplicationRecord

  has_many :instituts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_products, through: :orders
  has_many :message_instituts, through: :instituts
  has_many :custom_soins, dependent: :destroy

  has_one_attached :photo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PALIERS = [600,1200,1800]
  REMISES = [10,15,20]

  include OrdersHelper

  CONDITIONS = ["30J FDM","30J net","60J net"]
  PAYMENT_MODE = ["LCR","Prélèvement SEPA","Chèque","Virement"]

  def instituts
    self.instituts = Institut.all.where(customer_id: self.id)
  end

  def panier_moyen(year)
    year = year
    orders = self.orders.where("EXTRACT(year FROM custom_date) = ?", year).where(state:"Payée")
    amount = Money.new(orders.map{|order| order.amount_ht_cents}.sum).fractional

    if orders.count != 0
      panier_moyen = amount / orders.count
    else
      panier_moyen = 0
    end

    panier_moyen = Money.new(panier_moyen).format.delete_prefix('€')
    return panier_moyen
  end

  def frequence_achat(year)
    year = year
    orders = self.orders.where("EXTRACT(year FROM custom_date) = ?", year).where(state:"Payée")
    return orders.count
  end

  def total_trimestre
    #"Hello, from an instance method"
    total_amount = 0
    orders = self.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?",Date.today.year,"Payée")

    trimestre(Date.today)[:trimestres].each do |trim|
      orders.where("EXTRACT(month FROM custom_date)= ?",trim).each do |ord|
        total_amount += ord.amount_ht
      end
    end
    return total_amount
  end


  def last_trimestre_amount(orders)
    amount = 0
    orders.each do |order|
      amount += order.amount_ht
    end
    return amount
  end

  def total_n
    year = Date.today.year
    total_amount = 0
    orders = self.orders.where("EXTRACT(year FROM custom_date) = ?", year)
    orders.each do |order|
      total_amount += order.amount_ht
    end
    return total_amount
  end

  def total_n_1
    year = Date.today.year - 1
    total_amount = 0
    orders = self.orders.where("EXTRACT(year FROM custom_date) = ?", year)
    orders.each do |order|
      total_amount += order.amount_ht
    end
    return total_amount

  end

  def total_facture_n(n)
    ## Montant ht payé par le client
    year = n
    total_amount = 0
    orders = self.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?",year,"Payée")
    orders.each do |order|
      total_amount += order.amount_ht
    end
    return total_amount
  end

  def orders_n(n)
    #commandes payée de l'année n par défaut sinon de l'année mentionée
    year = n
    orders_payees = self.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?",year,"Payée")
    return orders_payees
  end



  def avantage_palier
     ## La remise obtenue pour les commandes du dernier trimestre.
    current_trimestre = trimestre(Date.today)
    if current_trimestre[:index] == 0
      year = Date.today.year - 1
      orders_year = self.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?", year,"Payée")

    else
      orders_year = self.orders.where("EXTRACT(year FROM custom_date) = ? AND state = ?", year,"Payée")
    end
    orders_last_trimestre = last_trimestre_orders(orders_year, current_trimestre[:index])
    last_trimestre_amount = self.last_trimestre_amount(orders_last_trimestre)
    #amount_avantages_ht = self.last_trimestre_amount(orders_last_trimestre)


    if last_trimestre_amount >= Money.new(Customer::PALIERS[2]*100)
      return Customer::REMISES[2].to_s+"%"
    elsif last_trimestre_amount >= Money.new(Customer::PALIERS[1]*100)
      return Customer::REMISES[1].to_s+"%"
    elsif last_trimestre_amount >= Money.new(Customer::PALIERS[0]*100)
      return Customer::REMISES[0].to_s+"%"
    else
      return "0%"
    end
  end

  def next_palier(amount)
    ## La remise obtenue pour les commandes payée en cours.
    if amount >= Money.new(Customer::PALIERS[2]*100)
      return Customer::REMISES[2].to_s+"%"
    elsif amount >= Money.new(Customer::PALIERS[1]*100)
      return Customer::REMISES[1].to_s+"%"
    elsif amount >= Money.new(Customer::PALIERS[0]*100)
      return Customer::REMISES[0].to_s+"%"
    else
      return "0%"
    end
  end
end
