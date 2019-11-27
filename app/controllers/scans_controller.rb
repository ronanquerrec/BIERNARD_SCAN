# require "google/cloud/vision"
class ScansController < ApplicationController
  def new
  end

  def create
    @scan_results = []

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    response = image_annotator.text_detection(
      image: "https://media.biernard.com/bieres/temp/26538-42867-v4_product_img.jpg",
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
