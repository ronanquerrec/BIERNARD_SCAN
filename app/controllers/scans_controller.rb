# require "google/cloud/vision"
class ScansController < ApplicationController
  def new
  end

  def create
    uploaded_file = params[:image]
    tmp_file = Tempfile.new(uploaded_file.original_filename)
    File.open(tmp_file.path, 'wb') do |file|
      file.write(uploaded_file.read)
    end
    res = Cloudinary::Uploader.upload(tmp_file.path)
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

    brewery = find_brewery(@scan_results)
    beer = find_best_matching_beer(@scan_results, brewery)
    redirect_to beer_path(beer)
  end

  private

  def find_best_matching_beer(texts, brewery = nil)
    beers = texts.map { |text| find_beers_from_text(text, brewery) }
    beers = beers.flatten - [nil]
    most_occuring_element(beers)
  end

  def find_beers_from_text(text, brewery)
    search = Beer.search do
      fulltext text do
        fields(:name)
      end
      fulltext brewery do
        fields(:brewery)
      end
    end
    search.results
  end

  def find_brewery(texts)
    breweries = texts.map { |text| find_brewery_from_text(text) }
    most_occuring_element(breweries - [nil])
  end

  def find_brewery_from_text(text)
    search = Beer.search do
      keywords text do
        fields(:brewery)
      end
    end
    search.results.first ? search.results.first.brewery : nil
  end

  def most_occuring_element(array)
    array.uniq
         .sort_by { |element| array.count(element) }
         .reverse
         .first
  end
end
