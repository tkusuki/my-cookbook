class RecipeTypesController < ApplicationController
  def show
    @recipe_types = RecipeType.find(params[:id])
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    recipe_type_name = params[:recipe_type][:name]
    @recipe_type = RecipeType.new(name: recipe_type_name)

    if @recipe_type.save
      redirect_to @recipe_type
    else
      render "new"
    end
  end

end
