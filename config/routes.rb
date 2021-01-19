Rails.application.routes.draw do
  root "static_pages#home"

  get "/about", to: "static_pages#about"

  get "/signup", to: "accounts#new"
  post "/signup", to: "accounts#create"
  get "/our_staff", to: "accounts#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  delete "/remove_service", to: "carts#remove_service"
  get "/remove_service", to: "carts#remove_service"

  resources :accounts
  resources :account_activations, only: :edit
  resources :services, only: %i(index show)
  resources :reviews, only: :destroy
  resources :orders, only: %i(index show create)
  resources :carts, only: %i(create index show)

  resources :accounts do
    resources :reviews, only: :create
  end


  resources :services do
    resources :reviews, only: :create
  end

  namespace :admin do
    get "statistics/accounts", to: "statistics#accounts"
    get "statistics/staffs", to: "statistics#staffs"
    get "statistics/revenue", to: "statistics#revenue"
    get "statistics/reviews", to: "statistics#reviews"
    get "account/customer", to: "accounts#index_customer"

    resources :orders, only: %i(index edit)
    resources :statistics, only: :index
    resources :accounts
  end

  namespace :staff do
    get "/my_received_order", to: "staffs#my_received_order"

    resources :work_histories, only: %i(index update)
    resources :staffs, only: %i(index update)
  end
end
