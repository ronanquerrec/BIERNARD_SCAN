# require "google/cloud/vision"
class ScansController < ApplicationController
  def new
  end

  def create
    # uploaded_file = params[:image]
    # tmp_file = Tempfile.new(uploaded_file.original_filename)
    # File.open(tmp_file.path, 'wb') do |file|
    #   file.write(uploaded_file.read)
    # end
    res = Cloudinary::Uploader.upload(params[:image])
    uploaded_url = res["url"]

    @scan_results = []

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    response = image_annotator.text_detection(
      image: uploaded_url,
      max_results: 1 # optional, defaults to 10
    )

    response.responses.each do |res|
      res.text_annotations.each do |text|
        @scan_results << text.description
      end
    end

    redirect_to beer_path(Beer.find_best_matching_beer(@scan_results))
  end
end
