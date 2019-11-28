class RecommendationsController < ApplicationController
  def index
    @style_reco = Beer.where(style: Favourite.last.beer.style).sample(5)
    @sweet_beers = Beer.where("sweetness > ?", 60).sample(5)
    # Reco 2
    # Manage to select all beers among the favourites
    # Manage to determine which tags are the most frequent among the favourites
    # Offer last recommendation based on most frequent beer tags
  end
end
