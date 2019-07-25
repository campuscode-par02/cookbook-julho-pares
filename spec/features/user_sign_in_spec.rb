require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    #arrange
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Logar'

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Bem vindo #{user.email}")
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and sign out' do
    #arrange
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Sair'

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_link('Entrar')
    expect(page).not_to have_content("Bem vindo #{user.email}")



  end
end