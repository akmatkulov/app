Rails.application.routes.draw do
  # users
  get "signup", to: "users#new"
  resources :users
  root "pages#home"
  # sessions
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
