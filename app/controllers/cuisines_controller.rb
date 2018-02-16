class CuisinesController < ApplicationController
  def show
    @cozinha = Cuisine.find(params[:id])
  end

  def new
    @cozinha = Cuisine.new
  end

  def create

    cuisine_params = params.require(:cuisine).permit(:name)

    @cozinha = Cuisine.new(cuisine_params)

    if (@cozinha.save)
      redirect_to cuisine_path(@cozinha.id)
    else
      render 'new'
    end

  end
end
