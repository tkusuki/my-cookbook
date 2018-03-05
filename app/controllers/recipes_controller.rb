class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.nil?
      flash[:notice] = "Receita não encontrada"
      redirect_to root_path
    end
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id,
                  :cuisine_id, :difficulty, :cook_time, :ingredients, :method)
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if (@recipe.save)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render "new"
    end
  end

  def edit
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    recipe_params = params.require(:recipe).permit(:title, :recipe_type_id,
                  :cuisine_id, :difficulty, :cook_time, :ingredients, :method)

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render "edit"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:notice] = "Receita removida com sucesso"
    redirect_to root_path
  end

  def search
    @search = params[:search]
    @recipes = Recipe.where("title LIKE ?", "%#{@search}%")
  end

end
