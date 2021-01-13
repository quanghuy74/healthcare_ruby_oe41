Rails.application.routes.draw do
  get  "/signup", to: "accounts#new"
  post "/signup", to: "accounts#create"
  root "static_pages#home"

  get "/about", to: "static_pages#about"
  
  resources :accounts, only: %i(new create show)
  resources :account_activations, only: :edit
end
