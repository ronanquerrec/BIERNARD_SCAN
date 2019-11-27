Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :beers, only: :show
  resources :favourites, only: [:index, :create, :destroy]
  resources :scans, only: [:new, :create]
end
