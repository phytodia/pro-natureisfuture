class Commercial < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  CUSTOMERS_NOT_COMMANDED =  {
    "6 mois"=>[],
    "9 mois"=>[],
    "12 mois et plus"=>[]
  }
  AMOUNT_HASH = {
    (Date.today.year).to_s => {
      "january" => {
        "all" =>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "february"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "march"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "april"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "mai"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "june"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "july"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "august"=>{
        "all"=>0,
        "Payée"=>0,
        "nombre"=>0
      },
      "september"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "october"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "november"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "december"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      }
    },
    (Date.today.year-1).to_s => {
      "january" => {
        "all" =>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "february"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "march"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "april"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "mai"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "june"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "july"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "august"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "september"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "october"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "november"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      },
      "december"=>{
        "all"=>0,
        "Payée"=>0,
        "reassort"=>0,
        "nombre"=>0
      }
    }
}
  def full_name
    "#{firstname} #{lastname}"
  end

  def customers
    Customer.where(commercial_id:self.id)
  end
end
