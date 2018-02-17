class HomeController < ApplicationController

  def index
    @receitas = Recipe.all
    @cozinhas = Cuisine.all
    @tipos_receitas = RecipeType.all
  end

end
