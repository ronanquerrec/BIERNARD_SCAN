class RecommendationsController < ApplicationController
  def index
    @gold_beers = Beer.where(colour: "Gold").first(5)
  end
end
