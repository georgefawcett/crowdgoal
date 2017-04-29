Rails.application.routes.draw do

  get 'galleries/create'

  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'sessions#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/login' => 'sessions#index'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/sendConfirmation' => 'mailers#sendConfirmation'

  resources :filters, only: [:show]

  resources :messages
  resources :reviews
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships,       only: [:create, :destroy]

  resources :galleries,       only: [:create, :destroy]
  resources :photos


  resources :events do
    resources :players, only: [:create, :destroy]
  end


  get '/register' => 'users#new'
  post '/register' => 'users#create'



 root to: "photos#index"


end
