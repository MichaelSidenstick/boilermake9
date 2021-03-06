Rails.application.routes.draw do
  devise_for :users
  resources :requests
  root to: "home#index"
  get '/current_request', to: 'home#current_request'
  get '/fulfilled_request', to: 'home#fulfilled_request'

  get "/requests/:id/add_product", to: "requests#add_product"
  get "/requests/new/:id/add_products", to: "requests#product_search"
  post "/requests/new/:id/add_products", to: "requests#product_search_redirect"
  get "/requests/:id/add_to_cart", to: "requests#add_to_cart"

  post "/requests/:id/add_to_cart", to: "requests#handle_conf"

  get "authenticate", to: "authenticate#main"
  get "authenticate/reset"
  get "authenticate/product"
  get "authenticate/cart"
  # get 'passwords', to: 'passwords#main'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
