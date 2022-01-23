Rails.application.routes.draw do
  devise_for :users
  resources :requests
  root to: "home#index"
  get "/requests/:id/add_product", to: "requests#add_product"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
