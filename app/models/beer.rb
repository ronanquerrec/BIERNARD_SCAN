class Beer < ApplicationRecord
  has_many :beer_flavours
  has_many :flavours, through: :beer_flavours

  searchable do
    text :name
    text :brewery
    text :style
  end
end
