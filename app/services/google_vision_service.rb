class GoogleVisionService
  def initialize(photo_url)
    @photo_url = photo_url
  end

  def texts_from_image
    scan_results = []

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    response = image_annotator.text_detection(
      image: @photo_url,
      max_results: 1 # optional, defaults to 10
    )

    response.responses.each do |res|
      res.text_annotations.each do |text|
        scan_results << text.description
      end
    end
    scan_results
  end

  def self.feed_json
    i = 1
    results = []
    Beer.all.sample(200).each do |beer|
      puts "------------Beer #{i} / 100------------------"
      results << {
        beer: beer.id,
        texts: GoogleVisionService.new(beer.url_image).texts_from_image
      }
      i += 1
    end

    File.open('test_data_beer_matching.json', 'wb') do |file|
      file.write(JSON.generate({ data: results }))
    end
  end

  def self.test_pourcentage_matching
    serialized_beers = File.read("test_data_beer_matching.json")

    results = JSON.parse(serialized_beers)
    good_results = 0
    results["data"].each do |result|
      beer = Beer.find(result["beer"])
      matched_beer = Beer.find_best_matching_beer(result["texts"])
      good_results += 1 if beer == matched_beer
    end
    good_results
  end
end
