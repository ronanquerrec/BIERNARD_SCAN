Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/test_matching', to: "pages#test_matching"

  resources :beers, only: :show
  resources :favourites, only: [:index, :create, :destroy]
  resources :recommendations, only: [:index]
  resources :scans, only: [:new, :create]

  get 'pages/test'
  get 'pages/no_match', to: 'pages#no_match', as: 'no_match'
end
