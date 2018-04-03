require 'rails_helper'

feature 'Visitor search for recipes' do
  scenario 'from home page' do
    # cria os dados necessarios
    user = User.create(email: 'thais@email.com', password: '12345678')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Entrada')

    recipe = Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
      restante dos ingredientes'
    )

    another_recipe = Recipe.create(
      user: user, title: 'Salada de cenoura', recipe_type: another_recipe_type,
      cuisine: cuisine, difficulty: 'Facil',  cook_time: 60,
      ingredients: 'Cenoura e legumes',
      method: 'Cozinhe a cenoura, misture com os legumes'
    )

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text:
      'Resultado da busca por: Bolo de cenoura')
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end
  scenario 'and navigate to recipe details' do
    # cria os dados necessarios previamente
    user = User.create(email: 'thais@email.com', password: '12345678')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
      restante dos ingredientes'
    )

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'
    click_on 'Bolo de cenoura'

    # expectativas do usuario apos a acao
    expect(current_path).to eq(recipe_path(recipe))
  end
  scenario 'and find all matches' do
    # cria os dados necessarios previamente
    user = User.create(email: 'thais@email.com', password: '12345678')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe_type = RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
      restante dos ingredientes'
    )

    another_recipe = Recipe.create(
      user: user, title: 'Bolo de chocolate', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cacau, ovo',
      method: 'Bata todos os ingredientes no liquidificador e leve ao forno
      por 40 minutos.'
    )

    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: 'Bolo'
    click_on 'Buscar'

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: 'Resultado da busca por: Bolo')

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end

  scenario 'and no results found' do
    # cria os dados necessarios
    user = User.create(email: 'thais@email.com', password: '12345678')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_cuisine = Cuisine.create(name: 'Japonesa')

    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Entrada')

    recipe = Recipe.create(
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
      restante dos ingredientes'
    )

    another_recipe = Recipe.create(
      user: user, title: 'Temaki', recipe_type: another_recipe_type,
      cuisine: another_cuisine, difficulty: 'Médio', cook_time: 60,
      ingredients: 'Arroz, nori, salmão e cebolinha',
      method: 'Cozinhe o arroz, corte o salmão e a cebolinha. Coloque tudo
      no nori e enrole em formato de cone'
    )
    # simula a acao do usuario
    visit root_path
    fill_in 'Busca', with: 'Feijoada'
    click_on 'Buscar'

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: 'Resultado da busca por: Feijoada')
    expect(page).to have_content('Nenhuma receita encontrada')
    expect(page).not_to have_css('h1', text: recipe.title)
    expect(page).not_to have_css('h1', text: another_recipe.title)
  end
end
