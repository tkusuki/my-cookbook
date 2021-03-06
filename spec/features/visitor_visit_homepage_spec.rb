require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
    expect(page).to have_css('p', text:
      'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    # cria os dados necessarios
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'medium',
      ingredients: 'Cenoura, acucar, oleo e chocolate',
      method: 'Misturar tudo, bater e assar', cook_time: 60
    )

    # simula a acao do usuario
    visit root_path

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: 'Médio')
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'medium',
      ingredients: 'Cenoura, acucar, oleo e chocolate',
      method: 'Misturar tudo, bater e assar', cook_time: 60, user: user
    )

    another_recipe = create(
      :recipe,
      title: 'Feijoada', cuisine: cuisine, difficulty: 'hard',
      ingredients: 'Feijao, paio, carne seca',
      method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
      cook_time: 90, user: user
    )

    # simula a acao do usuario
    visit root_path
    # expect(page).to have_css('li', text: recipe.difficulty)

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: 'Médio')
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: 'Difícil')
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end
  scenario 'and view all registered recipes' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'medium',
      ingredients: 'Cenoura, acucar, oleo e chocolate',
      method: 'Misturar tudo, bater e assar', cook_time: 60, user: user
    )

    another_recipe_type = create(:recipe_type)
    another_recipe = create(
      :recipe,
      title: 'Feijoada', recipe_type: another_recipe_type, cuisine: cuisine,
      difficulty: 'hard', ingredients: 'Feijao, paio, carne seca',
      method: 'Cozinhar o feijao e refogar com as carnes já preparadas',
      cook_time: 90, user: user
    )

    # simula a acao do usuario
    visit root_path
    click_on 'Ver todas as receitas'

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: 'Médio')
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: 'Difícil')
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end
end
