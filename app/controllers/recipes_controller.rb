class RecipesController < ApplicationController
  def show
    @receita = Recipe.find(params[:id])
  end

  def new
    @receita = Recipe.new
  end

  def create

    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)

    @receita = Recipe.new(recipe_params)

    if (@receita.save)
      # redirect_to @receita
      redirect_to recipe_path(@receita.id)
    else
      render 'new'
    end
  end
end
