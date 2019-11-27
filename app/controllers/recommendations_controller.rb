class RecommendationsController < ApplicationController
  def index
    # You'll have to modify this method later
    @recommendations = Favourite.all
  end
end
