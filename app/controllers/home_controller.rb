class HomeController < ApplicationController

  def index
    @receitas = Recipe.all
    # destruir = Recipe.find(2)
    # destruir.destroy
  end

end
