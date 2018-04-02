require 'rails_helper'

feature 'User remove recipe' do
  scenario 'successfully' do
    # cria os dados necessários
    user = create(:user)

    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(
      user: user, title: 'Bruschetta', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Fácil', cook_time: 30,
      ingredients: 'Pão italiano, tomates, cebola, azeite',
      method: 'Pique o tomate e a cebola, monte no pão cortado e leve ao forno'
    )

    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on recipe.title
    click_on 'Remover'

    # expectativas do usuário após a ação
    expect(page).to have_content('Receita removida com sucesso')

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
  scenario 'and try to remove the same recipe again' do

    # cria os dados necessários
    user = create(:user)

    cuisine = Cuisine.create(name: 'Italiana')
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(
      user: user, title: 'Bruschetta', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Fácil', cook_time: 30,
      ingredients: 'Pão italiano, tomates, cebola, azeite',
      method: 'Pique o tomate e a cebola, monte no pão cortado e leve ao forno'
    )

    # simula a ação do usuário
    login_as(user)
    visit root_path
    click_on recipe.title
    click_on 'Remover'
    visit recipe_path(recipe.id)

    # expectativas do usuário após a ação
    expect(page).to have_content('Receita não encontrada')

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
end
