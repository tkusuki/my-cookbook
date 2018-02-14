class RecipesController < ApplicationController
  def show
    @receita = Recipe.find(params[:id])
  end

  def new
    @receita = Recipe.new
  end

  def create
    recipe = params[:recipe]
    title = recipe[:title]

    title = recipe[:title]
    recipe_type = recipe[:recipe_type]
    cuisine = recipe[:cuisine]
    difficulty = recipe[:difficulty]
    cook_time = recipe[:cook_time]
    ingredients = recipe[:ingredients]
    method = recipe[:method]

    @receita = Recipe.new(
                          title: title,
                          recipe_type: recipe_type,
                          cuisine: cuisine,
                          difficulty: difficulty,
                          cook_time: cook_time,
                          ingredients: ingredients,
                          method: method
                        )
    if (@receita.save)
      redirect_to @receita
    else
      render 'new'
    end
  end


end
