require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)

    create(:cuisine, name: 'Arabe')
    create(:recipe_type)
    create(:recipe_type, name: 'Entrada')
    create(:recipe_type, name: 'Sobremesa')

    # simula a acao do usuario
    login_as(user)
    visit root_path

    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Fácil', from: 'Dificuldade'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with:
      'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with:
      'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto', Rails.root.join('spec', 'support', 'recipe.png'))
    click_on 'Criar Receita'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css("img[src*='recipe.png']")
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text:
      'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:
      'Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_css('p', text: "Enviada por: #{user.email}")
  end
  scenario 'and must fill in all fields' do
    # cria os dados necessarios
    user = create(:user)
    create(:cuisine, name: 'Arabe')

    # simula a acao do usuario
    login_as(user)
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    select 'Fácil', from: 'Dificuldade'
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Criar Receita'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
