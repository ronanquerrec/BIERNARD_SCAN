puts 'Cleaning database...'
Beer.destroy_all
Flavour.destroy_all
BeerFlavour.destroy_all
User.destroy_all

puts "creating flavor tags..."

malt = Flavour.create!(name: 'malt')
caramel = Flavour.create!(name: 'caramel')


puts 'Creating beers...'
beer = Beer.create!(
  name: "Boont Amber Ale",
  description: "La bière Boont Amber Ale de la brasserie Anderson Valley Brewing Co., Etats-Unis.",
  fizzing: 51,
  bitterness: 40,
  sweetness: 40,
  alcohol_percentage: 5.8,
  brewery: "Anderson Valley Brewing Co.",
  country: "Etats-Unis",
  url_image: "https://media.biernard.com/bieres/temp/1996-13880-v4_product_img.jpg",
  style: "Amber Ale",
  strength: 10,
  sourness: 6.7,
  colour: "Amber"
)

puts 'Creating users...'
User.create!(
  email: 'jean@beer.com',
  password: "123456"
)

BeerFlavour.create!(
  beer: beer,
  flavour: malt
)

BeerFlavour.create!(
  beer: beer,
  flavour: caramel
)

puts 'Finished!'



