Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :products

  post '/search', to: "searches#create"

  post '/signup', to: 'users#create'
  post '/login', to: 'auth#create'
  get 'me', to: 'users#profile'
end
