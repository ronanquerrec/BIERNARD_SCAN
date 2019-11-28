class RecommendationsController < ApplicationController
  def index
    @gold_beers = Beer.where(colour: "Gold").first(5)
    @sweet_beers = Beer.where("sweetness > ?", 60).first(5)
    @style_reco = Beer.where(style: Favourite.last.beer.style).first(5)
  end
end
