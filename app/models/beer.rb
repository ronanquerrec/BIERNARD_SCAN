class Beer < ApplicationRecord
  has_many :beer_flavours
  has_many :flavours, through: :beer_flavours

end
