Rails.application.routes.draw do
  devise_for :users
  resources :requests
  root to: "home#index"
  get '/current_request', to: 'home#current_request'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
