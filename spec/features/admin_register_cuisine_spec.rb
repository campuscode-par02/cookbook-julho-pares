require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Cadastrar'

    expect(current_path).to eq cuisine_path(Cuisine.last)
    expect(page).to have_css('h1', text: 'Brasileira')
    expect(page).to have_content('Cozinha cadastrada com sucesso')
  end

  scenario 'fails if name is empty' do
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('Você deve informar o nome da cozinha')
  end

  scenario 'fails if name is not unique' do
    cuisine_name = 'Brasileira'
    cuisine = Cuisine.create!(name: cuisine_name)
    
    visit root_path
    click_on 'Cadastrar cozinha'
    fill_in 'Nome', with: cuisine_name
    click_on 'Cadastrar'

    expect(page).to have_content('Já existe uma cozinha com este nome')
  end
end