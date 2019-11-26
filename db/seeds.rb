puts 'Cleaning database...'
BeerFlavour.destroy_all
Flavour.destroy_all
User.destroy_all
Beer.destroy_all


# malt = Flavour.create!(name: 'malt')
# caramel = Flavour.create!(name: 'caramel')


# beer = Beer.create!(
#   name: "Boont Amber Ale",
#   description: "La bière Boont Amber Ale de la brasserie Anderson Valley Brewing Co., Etats-Unis.",
#   fizzing: 51,
#   bitterness: 40,
#   sweetness: 40,
#   alcohol_percentage: 5.8,
#   brewery: "Anderson Valley Brewing Co.",
#   country: "Etats-Unis",
#   url_image: "https://media.biernard.com/bieres/temp/1996-13880-v4_product_img.jpg",
#   style: "Amber Ale",
#   strength: 10,
#   sourness: 6.7,
#   colour: "Amber"
# )

puts 'Creating users...'
User.create!(
  email: 'jean@beer.com',
  password: "123456"
)

# BeerFlavour.create!(
#   beer: beer,
#   flavour: malt
# )

# BeerFlavour.create!(
#   beer: beer,
#   flavour: caramel
# )



require 'json'

filepath = "#{Rails.root}/db/beers.json"

serialized_beers = File.read(filepath)

beers = JSON.parse(serialized_beers)

puts 'Creating beers...'
puts "creating flavor tags..."
beers["beers"].each do |beer|

  beer_record = Beer.create!(
    name: beer["name"],
    description: beer["description"],
    fizzing: beer["effervescentAvg"],
    bitterness: beer["bitterness"],
    sweetness: beer["sweetness"],
    alcohol_percentage: beer["alcohol_degree"],
    brewery: beer["brewer"],
    country: beer["country"],
    url_image: beer["url_image"],
    style: beer["style"],
    strength: beer["power"],
    sourness: beer["acidity"],
    colour: beer["color"]
  )
  # array of strings
  beer["flavors_tags"].each do |beer_flavor_tag|
    # first iteration: beer_flavor_tag = "malt"
    # first iteration: beer_flavor_tag = "caramel"
    # 1.
    flavour = Flavour.find_or_create_by!(name: beer_flavor_tag)
    BeerFlavour.create!(
      beer: beer_record,
      flavour: flavour
    )
  end

end


puts 'Finished!'

