class HomeController < ApplicationController

  def index
    @receitas = Recipe.all
    @cozinhas = Cuisine.all
    # destruir = Recipe.find(12)
    # destruir.destroy
  end

end
