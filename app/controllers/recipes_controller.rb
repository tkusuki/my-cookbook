class RecipesController < ApplicationController
  def show
    @receita = Recipe.find(params[:id]) 
  end


end
