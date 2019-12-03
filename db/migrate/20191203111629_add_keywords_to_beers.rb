class AddKeywordsToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :keywords, :string
  end
end
