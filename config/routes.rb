Rails.application.routes.draw do
  devise_for :users
  resources :requests
  root to: "home#index"

  get "authenticate", to: "authenticate#main"
  get "authenticate/reset"
  get "authenticate/product"
  get "authenticate/cart"
  # get 'passwords', to: 'passwords#main'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
