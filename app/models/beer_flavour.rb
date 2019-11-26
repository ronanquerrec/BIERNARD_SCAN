class BeerFlavour < ApplicationRecord
  belongs_to :flavour
  belongs_to :beer
end
