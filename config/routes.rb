Rails.application.routes.draw do
  root "pages#home"

  # users
  get "signup", to: "users#new"
  resources :users

  # account activations
  resources :account_activations, only: %i[ edit ]

  # password resets
  resources :password_resets, only: %i[ new create edit update]

  # sessions
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
