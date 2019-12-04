class Beer < ApplicationRecord
  has_many :beer_flavours
  has_many :flavours, through: :beer_flavours

  LOW_SCORE_STRINGS = %w[de ale brewing ipa the pale la a blonde beer e d biere black vol tripel n alc aged in and]

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

  def compute_matching_score(texts)
    global_score = 0
    texts.each do |text|
      global_score += compute_score_of_text(text)
    end
    global_score
  end

  def compute_score_of_text(text)
    return 0 if (self.keywords.nil? || text.size < 3 || LOW_SCORE_STRINGS.include?(text.downcase))

    text = text.downcase
    keywords = self.keywords.split.map(&:downcase)
    keywords = keywords - LOW_SCORE_STRINGS

    keywords.each do |keyword|
      distance = LevenshteinsController.distance(text, keyword)
      if distance < 2
        return ([keyword.length, text.length].min * 2).fdiv([keyword.length, text.length].max)

      end
    end

    return 0

  end
end
