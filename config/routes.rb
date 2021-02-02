Rails.application.routes.draw do
  root "static_pages#home"

  get "/about", to: "static_pages#about"

  get "/signup", to: "accounts#new"
  post "/signup", to: "accounts#create"
  get "/our_staff", to: "accounts#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :accounts
  resources :account_activations, only: :edit
  resources :services, only: %i(index show)
  resources :reviews, only: :destroy
  resources :orders, only: %i(index show)

  resources :accounts do
    resources :reviews, only: :create
  end

  resources :services do
    resources :reviews, only: :create
  end

  namespace :admin do
    resources :orders, only: %i(index edit)
  end

  namespace :staff do
    get "/my_received_order", to: "staffs#my_received_order"

    resources :work_histories, only: %i(index update)
    resources :staffs, only: %i(index update)
  end
end
