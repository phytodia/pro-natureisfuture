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
end
