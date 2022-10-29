Rails.application.routes.draw do
  resources :reactions
  resources :values
  resources :addresses
  resources :locations
  resources :users
  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
