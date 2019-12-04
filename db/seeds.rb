puts 'Cleaning database...'
BeerFlavour.destroy_all
Favourite.destroy_all
Flavour.destroy_all
User.destroy_all
Beer.destroy_all

puts 'Creating users...'
user = User.create!(
  email: 'jean@beer.com',
  password: "123456"
)

require 'json'
require 'open-uri'

url = 'https://gist.githubusercontent.com/HadrienDT/5834109f3f52a90796dac82259022aec/raw/cc1b23b2d12a86714c52fb07c877898ccaf729ee/beers.json'

# filepath = "#{Rails.root}/db/beers.json"

# serialized_beers = File.read(filepath)
serialized_beers = open(url).read

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

    flavour = Flavour.find_or_create_by!(name: beer_flavor_tag)
    BeerFlavour.create!(
      beer: beer_record,
      flavour: flavour
    )
  end

end

puts "Creating favorites beers list..."
10.times do
  Favourite.create!(
    user: user,
    beer: Beer.all.sample
    )
end

puts "Translating flavours to french ..."
Flavour.translate


puts 'Finished!'

