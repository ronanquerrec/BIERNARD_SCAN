class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @beer = Beer.find(params[:id])
    @favourite = Favourite.where(user: current_user, beer: @beer).first || Favourite.new
  end
end
