require 'rails_helper'

feature 'User register recipe' do
  scenario 'must be signed in' do
    visit root_path
    expect(page).not_to have_link('Enviar uma receita')
  end

  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Arabe')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'bolo-de-cenoura.jpg')
    click_on 'Enviar'

    # expectativas
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
    expect(page).to have_css('img[src*="bolo-de-cenoura.jpg"]')
    expect(Recipe.last.user).to eq user
  end

  scenario 'and can see in his recipes list' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Arabe')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)

    # simula a ação do usuário
    login_as(user)
    visit root_path

    click_on 'Minhas Receitas'

    # expectativas
    expect(page).to have_css('h1', text: 'Minhas Receitas')
    expect(page).to have_content('Bolo de cenoura')
  end

  scenario 'and must fill in all fields' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'


    expect(page).to have_content('Não foi possível salvar a receita')
  end
end
