# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password')

empresa = Tag.create!(name: 'empresa')
ensino = Tag.create!(name: 'ensino')

Product.create!(name: 'IBM', tags: [empresa])
Product.create!(name: 'Microsoft', tags: [empresa])
Product.create!(name: 'UVA', tags: [empresa, ensino])

WhiteList.create!(domain: 'ibm.com.br')
WhiteList.create!(domain: 'microsoft.com')

