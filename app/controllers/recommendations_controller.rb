class RecommendationsController < ApplicationController
  def index
    @style_reco = Beer.where(style: Favourite.last.beer.style).sample(10)
    @sweet_beers = Beer.where("sweetness > ?", 60).sample(5)
    # Base recommendation on most frequent tags
  end

  # Sort most frequent flavours in favourites
  def favtag
    all_tags = []
    Favourite.all.each do |favourite|
      all_tags << favourite.beer.flavours.map { |flavour| flavour.name }
    end
    all_tags
  end
end
