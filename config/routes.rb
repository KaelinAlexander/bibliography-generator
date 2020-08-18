Rails.application.routes.draw do
  resources :users
  resources :bibliographies
  resources :texts
  resources :citations
  resources :authors

  get 'search', to: 'search#new'
  post 'search', to: 'search#create'
  get 'results', to: 'search#results'
  
end
