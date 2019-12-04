# require "google/cloud/vision"
class ScansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @page_title = "scan"
  end

  def create
    start_ts = Time.now
    res = Cloudinary::Uploader.upload(params[:image])
    end_ts = Time.now

    puts "#{(end_ts - start_ts)} s to send image"

    uploaded_url = res["url"]
    google_vision = GoogleVisionService.new(uploaded_url)

    @scan_results = google_vision.texts_from_image


    start_ts_2 = Time.now
    toto = Beer.find_best_matching_beer(@scan_results)
    end_ts_2 = Time.now
    puts "#{(end_ts_2 - start_ts_2)} s to get beer from image"

    redirect_to beer_path(Beer.find_best_matching_beer(@scan_results))
  end
end
