require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    # cria os dados necessarios
    user = User.create(email: 'thais@email.com', password: '12345678')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
              misture com o restante dos ingredientes'
    )

    # simula a acao do usuario
    visit root_path
    click_on cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end
  scenario 'and view only cuisine recipes' do
    # cria os dados necessarios previamente
    user = User.create(email: 'thais@email.com', password: '12345678')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    dessert_recipe_type = RecipeType.create(name: 'Sobremesa')
    Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: dessert_recipe_type,
      cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
              misture com o restante dos ingredientes'
    )

    italian_cuisine = Cuisine.create(name: 'Italiana')
    main_recipe_type = RecipeType.create(name: 'Prato Principal')
    italian_recipe = Recipe.create(
      user: user, title: 'Macarrão Carbonara', recipe_type: main_recipe_type,
      cuisine: italian_cuisine, difficulty: 'Difícil', cook_time: 30,
      ingredients: 'Massa, ovos, bacon',
      method: 'apósFrite o bacon; Cozinhe a massa ate ficar al dent;
              Misture os ovos e o bacon a massa ainda quente;'
    )
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_css('li', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('li', text: italian_recipe.cuisine.name)
    expect(page).to have_css('li', text: italian_recipe.difficulty)
    expect(page).to have_css('li', text: "#{italian_recipe.cook_time} minutos")
  end
  scenario 'and cuisine has no recipe' do
    # cria os dados necessarios previamente
    user = User.create(email: 'thais@email.com', password: '12345678')
    brazilian_cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
              misture com o restante dos ingredientes'
    )

    italian_cuisine = Cuisine.create(name: 'Italiana')
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este
                                tipo de cozinha')
  end
end
