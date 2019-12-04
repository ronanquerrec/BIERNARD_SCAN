class Flavour < ApplicationRecord
  has_many :beer_flavours
  has_many :beers, through: :beer_flavours

  TRANSLATIONS = {
    "malt" => "malt",
    "caramel" => "caramel",
    "walnut" => "noisette",
    "honey" => "miel",
    "orange" => "orange",
    "grapefruit" => "pamplemousse",
    "apricot" => "abricot",
    "berry" => "fruits rouges",
    "cherry" => "cerise",
    "plum" => "prune",
    "grape" => "raisin",
    "peach" => "pêche",
    "mango" => "mangue",
    "vanilla" => "vanille",
    "raspberry" => "framboise",
    "chocolate" => "chocolat",
    "banana" => "banane",
    "lemon" => "citron",
    "cereal" => "céréales",
    "pineapple" => "ananas",
    "coffee" => "café",
    "liquorice" => "réglisse",
    "apple" => "pomme",
    "pear" => "poire",
    "cinnamon" => "cannelle",
    "strawberry" => "fraise",
    "watermelon" => "pastèque",
    "pine" => "pin",
    "coco" => "noix de coco",
    "mint" => "menthe",
    "chestnut" => "châtaigne",
    "beetroot" => "betterave",
    "anis" => "anis",
    "violet" => "violette",
    "basil" => "basilic"
  }

  def self.translate
    Flavour.all.each do |flavour|
      flavour.name = TRANSLATIONS[flavour.name]
      flavour.save!
    end
  end
end
