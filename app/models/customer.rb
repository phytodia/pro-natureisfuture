class Customer < ApplicationRecord

  has_many :instituts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_products, through: :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  CONDITIONS = ["30J FDM","30J net","60J net"]
  PAYMENT_MODE = ["LCR","Prélèvement SEPA","Chèque","Virement"]

  def instituts
    self.instituts = Institut.all.where(customer_id: self.id)
  end

  def total_trimestre
    #"Hello, from an instance method"
    total_amount = 0
    self.orders.each do |order|
      total_amount += order.amount_ht
    end
    return total_amount
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
end
