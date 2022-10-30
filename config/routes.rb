# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "articles#index"

  resources :reactions
  resources :values
  resources :addresses
  resources :locations
  resources :users
  resources :articles
end
