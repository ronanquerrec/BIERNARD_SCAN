class RecommendationsController < ApplicationController
  def index
    @page_title = "recommendations_index"
    @first_reco_beers = Beer.joins(:flavours).where("flavours.name = ?", favourite_beer_tags[0])
    @first_reco_beers = (@first_reco_beers - current_user.beers).first(10)
    @second_reco_beers = Beer.joins(:flavours).where("flavours.name = ?", favourite_beer_tags[1])
    @second_reco_beers = remove_duplicate(@second_reco_beers, @first_reco_beers)
    @second_reco_beers = (@second_reco_beers - current_user.beers).first(10)
    @third_reco_beers = Beer.joins(:flavours).where("flavours.name = ?", favourite_beer_tags[2])
    @concatenated_array = @first_reco_beers + @second_reco_beers
    @third_reco_beers = remove_duplicate(@third_reco_beers, @concatenated_array)
    @third_reco_beers = (@third_reco_beers - current_user.beers).first(10)
    @first_tag = favourite_beer_tags[0]
    @second_tag = favourite_beer_tags[1]
    @third_tag = favourite_beer_tags[2]
  end

  def remove_duplicate(array_to_clean, array_compared)
    new_array = array_to_clean - array_compared
    return new_array
  end

  private

  def favourite_beer_tags
    tags = []
    current_user.beers.each do |beer|
      tags << beer.flavours.map { |flavour| flavour.name }
    end
    tags = tags.flatten
    tags.group_by {|i| i }.map { |k, v| [k, v.length] }
        .sort_by { |array| array.last }.reverse.first(3)
        .map { |array| array.first }
  end
end

# Beer.where("sweetness > ?", 60).sample(5)
# favourite_beer_tags == :flavours).first(10
