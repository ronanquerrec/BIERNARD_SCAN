class RecommendationsController < ApplicationController
  before_action :set_beer, only: [:create, :destroy]

  def index
    # You'll have to modify this method later
    @beers = current_user.beers
  end

  private

  def set_beer
    @beer = Beer.find(favourite_params[:beer_id])
  end

  def favourite_params
    params.require(:favourite).permit(:beer_id)
  end
end
