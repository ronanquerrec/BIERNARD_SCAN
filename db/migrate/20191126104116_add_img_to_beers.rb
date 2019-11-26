class AddImgToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :url_image, :string
  end
end
