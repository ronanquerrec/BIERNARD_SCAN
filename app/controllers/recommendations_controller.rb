class RecommendationsController < ApplicationController
  def index
    @reco_beers = Beer.where(favourite_beer_tags == :flavours)
  end

  def favourite_beer_tags
    tags = []
    Favourite.all.each do |favourite|
      tags << favourite.beer.flavours.map { |flavour| flavour.name }
    end
    tags = tags.flatten
    tags.group_by{|i| i.capitalize}.map { |k, v| [k, v.length] }
    tags.sort_by { |array| array.last }.reverse.first(3)
  end
end

# Beer.where("sweetness > ?", 60).sample(5)
