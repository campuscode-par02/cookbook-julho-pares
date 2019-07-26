require 'rails_helper'

feature 'User view lists' do
  scenario 'successfully' do
    #arrange
    user = User.create(email: 'par02@email.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Churrasco', 
                           difficulty: 'Médio', 
                           recipe_type: recipe_type, 
                           cuisine: cuisine, 
                           cook_time: 50, 
                           ingredients: 'Carne, linguiça e toucinho', 
                           cook_method: 'Leve na churrasqueira e deixe assar', 
                           user: user)
    
    other_recipe = Recipe.create(title: 'Feijoada', 
                           difficulty: 'Médio', 
                           recipe_type: recipe_type, 
                           cuisine: cuisine, 
                           cook_time: 50, 
                           ingredients: 'Carne de porco e feijão', 
                           cook_method: 'Cozinhe na panela de pressão', 
                           user: user)
    
    list = List.create(name: 'Churras da Campus', user: user)
    list_recipe = ListRecipe.create(list: list, recipe: recipe)

    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '123456'
    click_on 'Logar'
    click_on 'Minhas listas'
    click_on 'Churras da Campus'

    #assert
    expect(page).to have_content('Churras da Campus')
    expect(page).to have_link('Churrasco')
    expect(page).not_to have_link('Feijoada')
  end
end