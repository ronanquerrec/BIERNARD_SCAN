class FavouritesController < ApplicationController
  before_action :set_beer, only: [:create, :destroy]

  def index
    @page_title = "favourites_index"
    @beers = current_user.beers.reverse
  end

  def create
    @favourite = Favourite.create(user: current_user, beer: @beer)

    respond_to do |format|
      format.html { redirect_to beer_path(@beer) }
      format.js
    end
  end

  def destroy
    favourite = Favourite.where(user: current_user, beer: @beer).first
    favourite.destroy
    @favourite = Favourite.new
    respond_to do |format|
      format.html { redirect_to beer_path(@beer) }
      format.js
    end
  end

  private

  def set_beer
    @beer = Beer.find(favourite_params[:beer_id])
  end

  def favourite_params
    params.require(:favourite).permit(:beer_id)
  end
end
