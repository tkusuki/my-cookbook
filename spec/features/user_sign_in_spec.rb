require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)

    # simula a acao do usuario
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'

    # expectativas do usuario apos a acao
    expect(page).to have_css('nav', text: "Olá #{user.email}")
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end
  scenario 'and sign out' do
    # cria os dados necessarios
    user = create(:user)

    # simula a acao do usuario
    login_as(user)
    visit root_path
    click_on 'Sair'

    # expectativas do usuario apos a acao
    expect(page).to have_css('p', text: 'Saiu com sucesso')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
  end
end
