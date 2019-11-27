Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :beers, only: :show
  resources :favourites, only: :index

  resources :scans, only: [:new, :create]

  get '/test', to: "pages#test"
  resources :favourites, only: :index

  get '/test', to: "pages#test"
end
