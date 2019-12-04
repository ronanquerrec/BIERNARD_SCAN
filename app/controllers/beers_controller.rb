class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @beer = Beer.find(params[:id])
    @favourite = Favourite.where(user: current_user, beer: @beer).first || Favourite.new
    @show_reco = Beer.where(style: Beer.find(params[:id]).style).sample(10)
    @show_reco.delete(@beer)
  end
end
