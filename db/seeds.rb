# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Channel.create!(name: 'GNT')
Channel.create!(name: 'Multishow')
Channel.create!(name: 'Telecine')

Tag.create!(name: 'online')
Tag.create!(name: 'grátis')
Tag.create!(name: 'completo')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
