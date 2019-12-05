# require "google/cloud/vision"
class ScansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @page_title = "scan"
  end

  def create
    res = Cloudinary::Uploader.upload(params[:image])
    uploaded_url = res["url"]
    google_vision = GoogleVisionService.new(uploaded_url)
    @scan_results = google_vision.texts_from_image
    beer = Beer.find_best_matching_beer_with_score(@scan_results)
    if beer[1] < 6
      redirect_to no_match_path
    else
      redirect_to beer_path(beer[0])
    end
  end
end
