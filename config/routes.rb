Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'sessions#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/login' => 'sessions#index'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :events

  get '/register' => 'users#new'
  post '/register' => 'users#create'

  get '/tests/new' => 'tests#new'
  post '/tests/new' => 'tests#create'

 root to: "photos#index"
  resources :photos

end
