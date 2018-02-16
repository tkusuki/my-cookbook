class CuisinesController < ApplicationController
  def show
    @cozinha = Cuisine.find(params[:id])
    @receitas = @cozinha.recipe
  end
end
