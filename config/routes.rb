Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :beers, only: :show
<<<<<<< HEAD
<<<<<<< HEAD
  resources :favourites, only: :index

  get '/test', to: "pages#test"
=======
>>>>>>> 34fd1affac1d14dc12bbacac5ec44f4b20fd0049
=======
  resources :favourites, only: :index

  get '/test', to: "pages#test"
>>>>>>> 62126a43a7a63b881ff83c8da56956f329fe6de4
end
