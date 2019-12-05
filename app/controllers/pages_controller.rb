class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def test_matching
    ts_start = Time.now
    @matching_data = GoogleVisionService.test_pourcentage_matching(params[:beers_to_test].to_i)
    ts_end = Time.now
    @duration = ts_end - ts_start
  end
end
