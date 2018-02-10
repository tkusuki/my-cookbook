class HomeController < ApplicationController

  def index
    @receitas = Recipe.all
  end

end
