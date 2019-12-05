Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/test_matching/:beers_to_test', to: "pages#test_matching"

  resources :beers, only: :show
  resources :favourites, only: [:index, :create, :destroy]
  resources :recommendations, only: [:index]
  resources :scans, only: [:new, :create]
end
