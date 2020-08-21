Rails.application.routes.draw do
  resources :users
  
  resources :bibliographies
  
  resources :texts

  resources :citations
  resources :authors

root 'sessions#new'

get '/search' => 'searches#show'
post '/search' => 'searches#show'
get '/login' => 'sessions#new'
post '/login' => 'sessions#create'
get '/logout' => 'sessions#destroy'
get '/hello' => 'users#show'
get '/signup' => 'users#new'
post '/signup' => 'users#create'
get 'bibliographies/:id/delete' => 'bibliographies#confirm'
get 'texts/:id/delete' => 'texts#confirm'
patch 'bibliographies/:id/style' => 'bibliographies#style'
  
end
