require 'rails_helper'

describe 'should send an email' do
  it 'sucessfully' do
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
    mail = RecipesMailer.send_recipe(recipe.id, name_from, email_to, msg)

    expect(mail.to).to include email_to
    expect(mail.subject).to eq "#{name_from} te enviou uma receita"
    expect(mail.body).to include "#{name_from} te enviou uma receita: #{recipe.title}"
    expect(mail.body).to include msg
  end
end