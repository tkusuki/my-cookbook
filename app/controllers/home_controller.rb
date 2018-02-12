class HomeController < ApplicationController

  def index
    @receitas = Recipe.all
    # destruir = Recipe.find(6)
    # destruir.destroy
  end

end
