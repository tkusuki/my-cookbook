class RecipeTypesController < ApplicationController
  def show
    @tipos_receitas = RecipeType.find(params[:id])
  end
end
