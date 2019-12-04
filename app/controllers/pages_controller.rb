class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def no_match
  end
  def test_matching
    ts_start = Time.now
    @matching_data = GoogleVisionService.test_pourcentage_matching
    ts_end = Time.now
    @duration = ts_end - ts_start
  end
end
