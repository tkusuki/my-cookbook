class RecipeTypesController < ApplicationController
  def show
    @recipe_types = RecipeType.find(params[:id])
  end
end
