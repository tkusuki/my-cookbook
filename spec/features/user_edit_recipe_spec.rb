require 'rails_helper'

feature 'User edit recipe' do
  scenario 'successfully' do

    # cria os dados necessários
    cuisine = Cuisine.create(name: "Italiana")
    recipe_type = RecipeType.create(name: 'Entrada')

    Cuisine.create(name: 'Japonesa')
    RecipeType.create(name: 'Prato Principal')
    RecipeType.create(name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bruschetta', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Fácil',
                          cook_time: 30,
                          ingredients: 'Pão italiano, tomates, cebola, azeite',
                          method: 'Pique o tomate e a cebola, monte no pão cortado e leve ao forno')

    # simula a ação do usuário
    visit root_path
    click_link recipe.title

    fill_in 'Título', with: 'Sushi de salmão'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Japonesa', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: 40
    fill_in 'Ingredientes', with: 'Gohan, nori, salmão'
    fill_in 'Como preparar', with: 'Cozinhe o arroz, monte o arroz e o salmão no nori e enrole'

    click_button 'Enviar'

    # expectativas do usuário após a ação
    expect(page).to have_css('h1', text: 'Sushi de salmão')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Tipo da Receita: Entrada')
    expect(page).to have_css('p', text: 'Cozinha: Japonesa')
    expect(page).to have_css('p', text: 'Dificuldade: Fácil')
    expect(page).to have_css('p', text: 'Tempo de Preparo: 40 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Gohan, nori, salmão')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text: 'Cozinhe o arroz, monte o arroz e o salmão no nori e enrole')
  end

  scenario 'and must fill in all fields' do

    cuisine = Cuisine.create(name: "Italiana")
    recipe_type = RecipeType.create(name: 'Entrada')
    recipe = Recipe.create(title: 'Bruschetta', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Fácil',
                          cook_time: 30,
                          ingredients: 'Pão italiano, tomates, cebola, azeite',
                          method: 'Pique o tomate e a cebola, monte no pão cortado e leve ao forno')

    # simula a ação do usuário
    visit root_path
    click_link recipe.title

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como preparar', with: ''

    click_button 'Enviar'

    # expectativas do usuário após a ação
    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

end
