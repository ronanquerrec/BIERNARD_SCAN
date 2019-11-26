class BeersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @beer = Beer.find(params[:id])
  end
end
