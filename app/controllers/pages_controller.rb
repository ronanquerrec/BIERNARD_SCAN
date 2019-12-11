class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :no_match, :autocomplete]

  def home
  end

  def no_match
  end

  def autocomplete
    query = params[:query]
    @beers = Beer.where("name ILIKE ?", "%#{query}%").first(10)
    render json: @beers
  end

  def test_matching
    ts_start = Time.now
    @matching_data = GoogleVisionService.test_pourcentage_matching(params[:beers_to_test].to_i)
    ts_end = Time.now
    @duration = ts_end - ts_start
  end
end
