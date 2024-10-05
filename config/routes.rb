Rails.application.routes.draw do
  root "pages#home"

  # users
  get "signup", to: "users#new"
  resources :users

  # sessions
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
