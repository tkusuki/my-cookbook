require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do

    # cria os dados necessários
    user = create(:user)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'

    # expectativas do usuário apos a ação
    expect(page).to have_css('nav', text: 'Olá thais@email.com')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end

  scenario 'and sign out' do
    # cria os dados necessários
    user = create(:user)

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Login'
    click_on 'Sair'

    # expectativas do usuário apos a ação
    expect(page).to have_css('p', text: 'Saiu com sucesso')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')

  end

end
