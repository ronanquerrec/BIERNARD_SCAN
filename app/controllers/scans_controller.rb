# require "google/cloud/vision"
class ScansController < ApplicationController

  def new
  end

  def create
    @scan_results = []

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    response = image_annotator.text_detection(
      image: "https://thumbs.dreamstime.com/z/bouteille-de-bi%C3%A8re-punk-de-brewdog-ipa-d-%C3%A9cossais-89494280.jpg",
      max_results: 1 # optional, defaults to 10
    )

    response.responses.each do |res|
      res.text_annotations.each do |text|

        @scan_results << text.description
      end
    end
    render :new
  end

end
