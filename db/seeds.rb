# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "create Users"
User.create!(email:"ev@phytodia.com", password:"123456")
User.create!(email:"mt@phytodia.com", password:"123456")
User.create!(email:"th@phytodia.com", password:"123456")
puts "create Commerciaux"
#TeamMember.create!(user_id:1, firstname:"Emilie", lastname:"Vanhoutte", role:"commercial")
#TeamMember.create!(user_id:2, firstname:"Marine", lastname:"Toussaint",role:"commercial")
puts "create profile commerciaux"
Profile.create!(firstname: "Emilie", lastname:"Vanhoutte", user_id:1)
Profile.create!(firstname: "Marine", lastname:"Toussaint", user_id:2)
Profile.create!(firstname: "Thomas", lastname:"Hunckler", user_id:3, role:"admin")

puts "create customer,commercial"
Commercial.create!(email:"test@commercial.com",password:"123456")
Customer.create!(email:"test@customer.com",password:"123456",commercial_id:1)

puts "create products"
Product.create!(
  name:"Crème anti-rides",description:"",actions_product:"",
  gamme:"visage",contenance_revente:20, contenance_cabine:100
)
Product.create!(
  name:"Crème hydratante",description:"",actions_product:"",
  gamme:"visage",contenance_revente:20, contenance_cabine:100
)
Product.create!(
  name:"Lait hydratant",description:"",actions_product:"",
  gamme:"corps",contenance_revente:20, contenance_cabine:100
)
Product.create!(
  name:"Gel minceur",description:"",actions_product:"",
  gamme:"corps",contenance_revente:20, contenance_cabine:100
)
Product.create!(
  name:"Huile tonifiante",description:"",actions_product:"",
  gamme:"corps",contenance_revente:20, contenance_cabine:100
)
puts "create soins"
Soin.create!(
  name:"Soin anti-âge",
  category:"visage",
  description:"Soin anti-âge description",
  estimated_time:"30"
)
Soin.create!(
  name:"Soin détox",
  category:"visage",
  description:"Soin détox description",
  estimated_time:"15"
)
Soin.create!(
  name:"Soin des mains",
  category:"corps",
  description:"Soin des mains description",
  estimated_time:"50"
)
Soin.create!(
  name:"Soin des pieds",
  category:"corps",
  description:"Soin des pieds description",
  estimated_time:"20"
)
Soin.create!(
  name:"Modelage tonifiant",
  category:"massage",
  description:"Modelage tonifiant description",
  estimated_time:"40"
)
Soin.create!(
  name:"Modelage relaxant",
  category:"massage",
  description:"Modelage relaxant description",
  estimated_time:"30"
)
