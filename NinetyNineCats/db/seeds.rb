# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
c1 = Cat.create!(birth_date: Date.new(2000,1,1), color: "fuschia", name: 'Feathers', sex: 'F', description: 'A lovely cat named Feathers!')

c1 = Cat.create!(birth_date: Date.new(2005,5,31), color: "red", name: 'Smithers', sex: 'M', description: 'Smithers coming at you!')

c1 = Cat.create!(birth_date: Date.new(2007,3,22), color: "white", name: 'Calvin', sex: 'M', description: 'The mob boss!')

cr1 = CatRentalRequest.create!(cat_id: c1.id, start_date: 1.days.from_now, end_date: 3.days.from_now)
