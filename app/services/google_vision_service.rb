class GoogleVisionService
  def initialize(photo_url)
    @photo_url = photo_url
  end

  def texts_from_image
    scan_results = []

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    image_context = {
      language_hints: %w[da, nl, en, fr, de, it, no, pl, pt, es]
    }
    response = image_annotator.text_detection(
      image: @photo_url,
      max_results: 1, # optional, defaults to 10
      image_context: image_context
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

    File.open('test_language_hints.json', 'wb') do |file|
      file.write(JSON.generate({ data: results }))
    end
  end

  def self.feed_db_with_keywords
    i = 1
    beers = Beer.all.where("keywords IS NULL")

    total = beers.size
    beers.each do |beer|
      puts "------------Beer #{i} / #{total} ------------------"
      texts = GoogleVisionService.new(beer.url_image).texts_from_image
      texts = texts[1..-1] if texts.size.positive?
      beer.keywords = texts.join(" ")
      beer.save!
      i += 1
    end
  end

  def self.test_pourcentage_matching
    beers = Beer.all.sample(10)
    beers.map do |beer|
      matched_beer = Beer.find_best_matching_beer_with_score(beer.keywords.split)
      matched_beer_name = matched_beer[0].name unless matched_beer[0].nil?
      matched_beer_brewery = matched_beer[0].brewery unless matched_beer[0].nil?
      good_matching = (beer == matched_beer[0])
      {
        beer_id: beer.id,
        beer_name: beer.name,
        beer_brewery: beer.brewery,
        beer_image: beer.url_image,
        texts: beer.keywords.split,
        matched_beer_name: matched_beer_name,
        matched_beer_brewery: matched_beer_brewery,
        good_matching: good_matching,
        score: matched_beer[1]
      }
    end
  end
end
