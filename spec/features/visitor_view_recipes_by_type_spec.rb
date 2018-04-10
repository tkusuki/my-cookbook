
require 'rails_helper'

feature 'Visitor view recipes by type' do
  scenario 'from home page' do
    # cria os dados necessarios
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    recipe = create(
      :recipe,
      title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
      misture com o restante dos ingredientes'
    )

    # simula a acao do usuario
    visit root_path
    click_on recipe_type.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe_type.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end
  scenario 'and view only recipes from same type' do
    # cria os dados necessarios
    user = create(:user)
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    dessert_recipe = create(
      :recipe,
      user: user, title: 'Bolo de cenoura', recipe_type: dessert_recipe_type,
      cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
              restante dos ingredientes'
    )

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type)
    main_recipe = create(
      :recipe,
      user: user, title: 'Macarrão Carbonara', recipe_type: main_recipe_type,
      cuisine: italian_cuisine, difficulty: 'Difícil', cook_time: 30,
      ingredients: 'Massa, ovos, bacon',
      method:
      'Frite o bacon; Cozinhe a massa ate ficar al dent;
      Misture os ovos e o bacon a massa ainda quente;'
    )
    # simula a acao do usuario
    visit root_path
    click_on main_recipe_type.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: main_recipe.title)
    expect(page).to have_css('li', text: main_recipe.recipe_type.name)
    expect(page).to have_css('li', text: main_recipe.cuisine.name)
    expect(page).to have_css('li', text: main_recipe.difficulty)
    expect(page).to have_css('li', text: "#{main_recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: dessert_recipe.title)
    expect(page).not_to have_css('li', text: dessert_recipe.recipe_type.name)
    expect(page).not_to have_css('li', text: dessert_recipe.cuisine.name)
    expect(page).not_to have_css('li', text: dessert_recipe.difficulty)
    expect(page).not_to have_css('li', text: "#{dessert_recipe.cook_time}
                                              minutos")
  end
  scenario 'and type has no recipe' do
    # cria os dados necessarios
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
              restante dos ingredientes'
    )

    main_dish_type = create(:recipe_type)
    # simula a acao do usuario
    visit root_path
    click_on main_dish_type.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de
                                receitas')
  end
end
