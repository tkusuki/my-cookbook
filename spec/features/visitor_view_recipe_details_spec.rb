require 'rails_helper'

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    method = 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o '
    method << 'restante dos ingredientes'
    recipe = create(
      :recipe,
      user: user, title: 'Bolo de cenoura', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'medium', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: method
    )

    # simula a acao do usuario
    visit root_path
    click_on recipe.title

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: recipe.method)
    expect(page).to have_css('p', text: "Enviada por: #{recipe.user.email}")
    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Remover')
  end
  scenario 'and return to recipe list' do
    # cria os dados necessarios
    user = create(:user)
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      user: user, title: 'Bolo de cenoura', recipe_type:  recipe_type,
      cuisine: cuisine, difficulty: 'medium', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
      restante dos ingredientes'
    )

    # simula a acao do usuario
    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
  scenario 'and the edit/remove links are disable if recipe is not yours' do
    user = create(:user)
    another_user = create(:user, email: 'another_user@email.com')

    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(
      :recipe,
      user: user, title: 'Bolo de cenoura', recipe_type:  recipe_type,
      cuisine: cuisine, difficulty: 'medium', cook_time: 60,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o
      restante dos ingredientes'
    )
    # simula a acao do usuario
    login_as(another_user)
    visit root_path
    click_on recipe.title

    # expectativas do usuario apos a acao
    expect(page).not_to have_link('Editar')
    expect(page).not_to have_link('Remover')
  end
end
