require 'rails_helper'

feature 'User searches a recipe.' do
  scenario 'by exact name' do

    # Setup
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Arabe')

    Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, leve ao forno',
      user: user)
    
    # Perform
    visit root_path
    
    fill_in "Digite o nome da receita", with: 'Bolo de Cenoura'
    click_on "Pesquisar"

    # Assert
    expect(page).to have_content('Bolo de Cenoura')
  end

  scenario 'by exact name and not find it.' do

    # Setup
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Arabe')

    Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, leve ao forno',
      user: user)
    
    # Perform
    visit root_path
    
    fill_in "Digite o nome da receita", with: 'Mousse de Maracuja'
    click_on "Pesquisar"

    # Assert
    expect(page).to have_content('Nenhuma receita encontrada')
    expect(page).not_to have_content('Mousse de Maracuja')
    expect(page).not_to have_content('Bolo de Cenoura')
  end

  scenario 'by partial name and finds it.' do

    # Setup
    user = User.create(email: 'par02@campuscode.com.br', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Arabe')

    Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
      cook_method: 'Cozinhe a cenoura, leve ao forno',
      user: user)

    Recipe.create(title: 'Bolo de Tomate', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50, ingredients: 'Farinha, açucar, tomate',
      cook_method: 'Cozinhe o tomate, leve ao forno',
      user: user)

    Recipe.create(title: 'Mousse de Maracuja', difficulty: 'Médio',
      recipe_type: recipe_type, cuisine: cuisine,
      cook_time: 50, ingredients: 'Farinha, açucar, maracujá',
      cook_method: 'Cozinhe o maracujá, leve ao forno',
      user: user)

    # Perform
    visit root_path
    
    fill_in "Digite o nome da receita", with: 'Bolo'
    click_on "Pesquisar"

     # Assert
     expect(page).to have_content('2 receitas encontradas')
     expect(page).to have_content('Bolo de Cenoura')
     expect(page).to have_content('Bolo de Tomate')
     expect(page).not_to have_content('Mousse de Maracuja')
  end
end
