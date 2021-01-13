Rails.application.routes.draw do
  root "static_pages#home"

  get "/about", to: "static_pages#about"

  get "/signup", to: "accounts#new"
  get "sessions/new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :accounts, only: %i(create show edit update)
end
