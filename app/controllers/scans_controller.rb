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

    redirect_to beer_path(Beer.find_best_matching_beer(@scan_results))
  end
end
