require 'rails_helper'

feature 'User send email to friend' do
  scenario 'successfully' do
    #arrange
    user = User.create(email: "joao@joao.com", password: "123456")
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes', user: user)
    name_from = 'Joao'
    email_to = 'rafael@email.com'
    msg = 'Aqui vai uma receita de bolo de cenoura'
    mailer_spy = class_spy('RecipesMailer')
    stub_const('RecipesMailer', mailer_spy)
    
    #act
    visit root_path
    click_on 'Bolo de cenoura'
    
    fill_in 'De', with: name_from
    fill_in 'Para', with: email_to
    fill_in 'Mensagem', with: msg
    click_on 'Enviar'

    #assert
    expect(RecipesMailer).to have_received(:send_recipe).with(recipe.id, name_from, email_to, msg)
    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_content('Mensagem enviada com sucesso')
  end
end