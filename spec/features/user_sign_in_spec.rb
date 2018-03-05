require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do

    # cria os dados necessários
    User.create(email: 'thais@email.com', password: '12345678')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'thais@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Login'

    # expectativas do usuário apos a ação
    expect(page).to have_css('nav', text: 'Olá thais@email.com')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end

  scenario 'and sign out' do
    # cria os dados necessários
    User.create(email: 'thais@email.com', password: '12345678')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'thais@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Login'
    click_on 'Sair'

    # expectativas do usuário apos a ação
    expect(page).to have_css('p', text: 'Saiu com sucesso')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')

  end

end
