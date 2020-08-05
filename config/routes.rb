Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  get '/auth/facebook/callback' => 'sessions#facebook_create'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users do
    resources :trips
  end

  resources :cities, only: [:index, :show, :new, :create]
  resources :countries, only: [:index, :show]
end
