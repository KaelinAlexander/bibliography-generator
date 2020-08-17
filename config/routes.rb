Rails.application.routes.draw do
  resources :users
  resources :bibliographies
  resources :texts
  resources :citations
  resources :authors
  
end
