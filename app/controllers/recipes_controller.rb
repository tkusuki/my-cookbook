class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create

    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
    @recipe = Recipe.new(recipe_params)

    if (@recipe.save)
      redirect_to @recipe
    else
      flash[:error] = "Você deve informar todos os dados da receita"
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render 'new'
    end
  end
end
