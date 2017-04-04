# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password')

online = Tag.create!(name: 'online')
gratis = Tag.create!(name: 'grátis')
completo = Tag.create!(name: 'completo')
dublado = Tag.create!(name: 'dublado')

Product.create!(name: 'PFC', tags: [online, gratis])
Product.create!(name: 'Premiere', tags: [online, gratis])
Product.create!(name: 'Telecine', tags: [gratis, dublado])

WhiteList.create!(domain: 'softonic.com.br')
WhiteList.create!(domain: 'softonic.com')
WhiteList.create!(domain: 'cnet.com')
WhiteList.create!(domain: 'tecnoblog.net')
WhiteList.create!(domain: 'uol.com.br')
WhiteList.create!(domain: 'saraiva.com.br')
WhiteList.create!(domain: 'enjoei.com.br')
WhiteList.create!(domain: 'techtudo.com.br')
WhiteList.create!(domain: 'reclameaqui.com.br')
WhiteList.create!(domain: 'eonline.com')
WhiteList.create!(domain: 'biblegateway.com')
WhiteList.create!(domain: 'bible.com')
WhiteList.create!(domain: 'estadao.com.br')
WhiteList.create!(domain: 'spotify.com')
WhiteList.create!(domain: 'archive.org')
WhiteList.create!(domain: 'vagalume.com.br')
WhiteList.create!(domain: 'ebay.com')
WhiteList.create!(domain: 'proteste.org.br')
WhiteList.create!(domain: 'adorocinema.com')
WhiteList.create!(domain: 'baixaki.org')
WhiteList.create!(domain: 'busindia.com')
WhiteList.create!(domain: 'aptoide.com')
WhiteList.create!(domain: 'oiplay.tv')
WhiteList.create!(domain: 'meiobit.com')
WhiteList.create!(domain: 'huffpostbrasil.com')
WhiteList.create!(domain: 'vejario.abril.com.br')
WhiteList.create!(domain: 'correio24horas.com.br')
WhiteList.create!(domain: 'tecmundo.com.br')
WhiteList.create!(domain: 'malavida.com')
