class Customer < ApplicationRecord

  has_many :instituts, dependent: :destroy
  has_many :orders, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def instituts
    self.instituts =  Institut.all.where(customer_id: self.id)
  end
end
