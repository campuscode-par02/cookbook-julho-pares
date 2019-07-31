Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes do
    post 'message'
  end
  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[show new create]
  resources :lists
  get 'search', to: 'recipes#search'
  get 'my_recipes', to: 'recipes#my_recipes'
end
