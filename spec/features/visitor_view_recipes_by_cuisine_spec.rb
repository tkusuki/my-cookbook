require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    recipe = create(
      :recipe,
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
    user = create(:user)
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    create(
      :recipe,
      user: user, title: 'Bolo de cenoura', recipe_type: dessert_recipe_type,
      cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
              misture com o restante dos ingredientes'
    )

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type)
    italian_recipe = create(
      :recipe,
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
    user = create(:user)
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: brazilian_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
              misture com o restante dos ingredientes'
    )

    italian_cuisine = create(:cuisine, name: 'Italiana')
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este
                                tipo de cozinha')
  end
end
