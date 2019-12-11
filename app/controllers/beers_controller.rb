class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    if params[:id] == "no_match"
      name = params[:query]
      @beer = Beer.where("name ILIKE ?", "%#{name}%").first
      @show_reco = Beer.where(style: Beer.find(@beer.id).style).sample(10)
    else
      @beer = Beer.find(params[:id])
      @show_reco = Beer.where(style: Beer.find(params[:id]).style).sample(10)
    end
    @favourite = Favourite.where(user: current_user, beer: @beer).first || Favourite.new
    @show_reco = Beer.where(style: Beer.find(@beer.id).style).sample(10)
    @show_reco.delete(@beer)
  end
end
