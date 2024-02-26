class Customer < ApplicationRecord

  has_many :instituts, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_products, through: :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PALIERS = [800,1500,4000]
  REMISES = [10,15,25]

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
end
