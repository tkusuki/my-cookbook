require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)
    arabian_cuisine = create(:cuisine, name: 'Arabe')
    create(:cuisine, name: 'Brasileira')

    main_type = create(:recipe_type)
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Sobremesa')

    create(
      :recipe,
      user: user, title: 'Bolodecenoura', recipe_type: main_type,
      cuisine: arabian_cuisine, difficulty: 'medium', cook_time: 50,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
              misture com o restante dos ingredientes'
    )

    # simula a acao do usuario
    login_as(user)
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    select 'medium', from: 'Dificuldade'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with:
      'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with:
      'Faça um bolo e uma cobertura de chocolate'

    click_on 'Atualizar Receita'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:
      'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text:
      'Faça um bolo e uma cobertura de chocolate')
  end
  scenario 'and all fields must be filled' do
    # cria os dados necessarios
    user = create(:user)

    arabian_cuisine = create(:cuisine, name: 'Arabe')
    create(:cuisine, name: 'Brasileira')

    main_type = create(:recipe_type)
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Sobremesa')

    create(
      :recipe,
      user: user, title: 'Bolodecenoura', recipe_type: main_type,
      cuisine: arabian_cuisine, difficulty: 'medium', cook_time: 50,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos,
      misture com o restante dos ingredientes'
    )

    # simula a acao do usuario
    login_as(user)
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''

    click_on 'Atualizar Receita'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
  scenario 'but is not owner of recipe' do
    # cria os dados necessarios
    user = create(:user)
    another_user = create(:user, email: 'another_user@email.com')
    cuisine = create(:cuisine, name: 'Italiana')
    recipe_type = create(:recipe_type, name: 'Entrada')
    recipe = create(
      :recipe,
      user: user, title: 'Bruschetta', recipe_type: recipe_type,
      cuisine: cuisine, difficulty: 'easy', cook_time: 30,
      ingredients: 'Pão italiano, tomates, cebola, azeite',
      method: 'Pique o tomate e a cebola, monte no pão cortado e leve ao forno'
    )

    # simula a acao do usuario
    login_as(another_user)
    visit edit_recipe_path(recipe)

    # expectativas de rota apos a acao
    expect(current_path).to eq(root_path)
  end
end
