Rails.application.routes.draw do

  get 'galleries/create'

  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'events#index'

  devise_for :users, skip: [:sessions,:registrations,:passwords], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/register' => 'users#new'
  post '/register' => 'users#create'

  get '/login' => 'sessions#index'
  post '/login' => 'sessions#create'
  # patch '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/change_password' => 'change_password#change'

  resources :forgot_password, only: [:index, :create, :update]


  # get '/sendConfirmation' => 'mailers#sendConfirmation'

  resources :filters, only: [:show]

  resources :messages
  resources :reviews

  resources :users  do
    collection do
      get :editopen, :editclose
    end
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




 root to: "photos#index"


end
