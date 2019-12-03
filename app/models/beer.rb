class Beer < ApplicationRecord
  has_many :beer_flavours
  has_many :flavours, through: :beer_flavours

  include PgSearch::Beer
  pg_search_scope :search_by_name,
  against: [:name],
  using: {
    tsearch: { prefix: true }
  }

  def self.find_best_matching_beer(texts)
    beers = Beer.all
    scored_beers = beers.map do |beer|
      [beer, beer.compute_matching_score(texts)]
    end
    scored_beers.sort_by { |scored_beer| scored_beer[1] }
                .reverse
                .first[0]
  end

  def compute_matching_score(texts)
    global_score = 0
    texts.each do |text|
      global_score += compute_score_of_text(text)
    end
    global_score
  end

  def compute_score_of_text(text)
    text = text.downcase
    name = self.name.downcase
    brewery = self.brewery.downcase

    score = 0

    if name.include?(text) || text.include?(name)
      score += ([name.length, text.length].min * 2).fdiv([name.length, text.length].max)
    end
    if brewery.include?(text) || text.include?(brewery)
      score += [brewery.length, text.length].min.fdiv([brewery.length, text.length].max)
    end

    score
  end
end
