Rails.application.routes.draw do
  root "pages#home"
  get "/users/new"
end
