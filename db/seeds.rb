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
TeamMember.create!(user_id:1, firstname:"Emilie", lastname:"Vanhoutte", role:"commercial")
TeamMember.create!(user_id:2, firstname:"Marine", lastname:"Toussaint",role:"commercial")
