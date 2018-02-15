class RecipesController < ApplicationController
  def show
    @receita = Recipe.find(params[:id])
  end

  def new
    @receita = Recipe.new
  end

  def create

    # recipe = params[:recipe]
    # title = recipe[:title]
    #
    # title = recipe[:title]
    # recipe_type = recipe[:recipe_type]
    # cuisine_id = recipe[:cuisine_id]
    # difficulty = recipe[:difficulty]
    # cook_time = recipe[:cook_time]
    # ingredients = recipe[:ingredients]
    # method = recipe[:method]
    #
    # @receita = Recipe.new(
    #                       title: title,
    #                       recipe_type: recipe_type,
    #                       cuisine_id: cuisine_id,
    #                       difficulty: difficulty,
    #                       cook_time: cook_time,
    #                       ingredients: ingredients,
    #                       method: method
    #                     )
    
    recipe_params = params.require(:recipe).permit(:title, :recipe_type, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)

    @receita = Recipe.new(recipe_params)

    if (@receita.save)
      redirect_to @receita
    else
      render 'new'
    end
  end
end
