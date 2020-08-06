Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/auth/facebook/callback' => 'sessions#alt_create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :users do
    resources :trips
  end

  resources :cities, only: [:index, :show, :new, :create]
  resources :countries, only: [:index, :show]

  get '/trips/five_star' => 'trips#five_star', as: :five_star
end
