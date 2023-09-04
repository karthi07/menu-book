# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Menu.create({dish_name: 'Briyani', dish_desc: 'Flavoured Chicken and Rice savoury', dish_type: 'Non-Veg', allergens: '', category: 'Main Course', price: 125})
Menu.create({dish_name: 'Porotta', dish_desc: 'Indian Bread', dish_type: 'Veg', allergens: 'contains gluten', category: 'Bread', price: 40})