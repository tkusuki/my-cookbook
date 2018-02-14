class HomeController < ApplicationController

  def index
    @receitas = Recipe.all
    # destruir = Recipe.find(12)
    # destruir.destroy
  end

end
