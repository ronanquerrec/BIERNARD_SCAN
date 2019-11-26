class Flavour < ApplicationRecord
  has_many :beer_flavours
  has_many :beers, through: :beer_flavours
end
