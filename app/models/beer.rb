class Beer < ApplicationRecord
  after_create :insert_keywords
  after_update :insert_keywords

  has_many :beer_flavours, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :flavours, through: :beer_flavours

  LOW_SCORE_STRINGS = %w[de ale brewing ipa the pale la a blonde beer e d biere black vol tripel n alc aged in and]

  def self.destroy_beers_without_images
    beers = Beer.where("url_image LIKE '%default%'")
    beers.each do |beer|
      beer.destroy
    end
  end

  def self.find_best_matching_beer(texts)
    find_best_matching_beer_with_score(texts)[0]
  end

  def self.find_best_matching_beer_with_score(texts)
    beers = Beer.all
    scored_beers = beers.map do |beer|
      [beer, beer.compute_matching_score(texts)]
    end
    scored_beers.sort_by { |scored_beer| scored_beer[1] }
                .reverse
                .first
  end

  def self.add_beers
    beer = Beer.create!(
      name: "Hair in the mailbox",
      description: "Hair in the Mailbox du brasseur danois Mikkeller est une IPA jaune-orange coiffée d'une large mousse blanche qui libère des arômes d'agrumes, de citron, de houblon et de malt. \nEn bouche, on y retrouve des saveurs de pamplemousse, de citron, de houblon, de malt, de pin, d'herbes et de fruits. \nElle est marquée par une amertume prenante et maîtrisée, menant vers une finale sèche et houblonnée.",
      fizzing: 60,
      bitterness: 60,
      sweetness: 35,
      alcohol_percentage: 6.3,
      brewery: "Mikkeller",
      country: "Danemark",
      url_image: "https://images.interdrinks.com/v5/img/p/32974-48623-w350-h455-transparent.png",
      style: "India Pale Ale",
      strength: 40,
      sourness: 10,
      colour: "Gold"
    )
    BeerFlavour.create!(
        beer: beer,
        flavour: Flavour.where(name: "citron").first
      )
    BeerFlavour.create!(
        beer: beer,
        flavour: Flavour.where(name: "malt").first
      )
    BeerFlavour.create!(
        beer: beer,
        flavour: Flavour.where(name: "pamplemousse").first
      )
  end

  def compute_matching_score(texts)
    global_score = 0
    texts.each do |text|
      global_score += compute_score_of_text(text)
    end
    global_score
  end

  def compute_score_of_text(text)
    return 0 if (self.keywords.nil? || text.size < 3)

    text = text.downcase
    keywords = self.keywords.split.map(&:downcase)

    multiplicator = LOW_SCORE_STRINGS.include?(text.downcase) ? 0.5 : 1

    # TROP LENT MAIS ON GARDE
    # keywords.each do |keyword|
    #   distance = LevenshteinsController.distance(text, keyword)
    #   if distance < 2
    #     return ([keyword.length, text.length].min * 2).fdiv([keyword.length, text.length].max)

    #   end
    # end

    keywords.each do |keyword|
      if keyword.include?(text) || text.include?(keyword)
        return multiplicator * ([keyword.length, text.length].min * 2).fdiv([keyword.length, text.length].max)

      end
    end
    return 0
  end

  def insert_keywords
    return if url_image.nil?

    texts = GoogleVisionService.new(url_image).texts_from_image
    texts = texts[1..-1] if texts.size.positive?
    self.keywords = texts.join(" ")
    self.save!
  end
end
