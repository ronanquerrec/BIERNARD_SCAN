class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def test_matching
    @matching_data = [
    {
        beer_id: 2,
        beer_name: "Delirum",
        beer_image: "https://media.biernard.com/bieres/temp/6493-15546-v4_product_img.jpg",
        texts: ["test","ekjrkdjfkjdfkjdkfjdkjfkdjfkjdfkjdkfjkdfjkj"],
        matched_beer_name: "dododo",
        matched_beer_brewery: "Super brasserie",
        good_matching: true,
        score: 1.17672617267162
      },
     {
        beer_id: 2,
        beer_name: "Delirum",
        beer_image: "https://media.biernard.com/bieres/temp/6493-15546-v4_product_img.jpg",
        texts: ["test","ekjrkdjfkjdfkjdkfjdkjfkdjfkjdfkjdkfjkdfjkj"],
        matched_beer_name: "dododo",
        matched_beer_brewery: "Super brasserie",
        good_matching: false,
        score: 1.17672617267162
      }]
    @matching_data = GoogleVisionService.test_pourcentage_matching
  end
end
