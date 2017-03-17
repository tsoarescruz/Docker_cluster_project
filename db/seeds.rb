# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

online = Tag.create!(name: 'online')
gratis = Tag.create!(name: 'grátis')
completo = Tag.create!(name: 'completo')
dublado = Tag.create!(name: 'dublado')

Channel.create!(name: 'PFC', tags: [online, gratis])
Channel.create!(name: 'Premiere', tags: [online, gratis])
Channel.create!(name: 'Telecine', tags: [gratis, dublado])

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
