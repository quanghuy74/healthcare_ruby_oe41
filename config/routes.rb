Rails.application.routes.draw do
  root "static_pages#home"

  get "/about", to: "static_pages#about"
  get "/our_staff", to: "accounts#index"
  delete "/remove_service", to: "carts#remove_service"

  devise_for :accounts
  resources :accounts, only: %i(index show)
  resources :services, only: %i(index show)
  resources :reviews, only: :destroy
  resources :orders, only: %i(index show create)
  resources :carts, only: %i(create index)

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
    get "accounts/customers", to: "accounts#index_customer"

    resources :orders, only: %i(index edit)
    resources :statistics, only: :index
    resources :accounts, expect: :show
  end

  namespace :staff do
    get "/my_received_order", to: "staffs#my_received_order"

    resources :work_histories, only: %i(index update)
    resources :staffs, only: %i(index update)
  end

  namespace :api do
    namespace :v1 do
      post "auth_account" => "authentication#authenticate_account"
      
      resources :accounts
    end
  end
end
