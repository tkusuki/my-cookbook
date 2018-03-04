class HomeController < ApplicationController
  def index
    @recipes_latest = Recipe.order(created_at: :desc).limit(6)
    @cuisines = Cuisine.all
    @recipe_types = RecipeType.all
  end
end
