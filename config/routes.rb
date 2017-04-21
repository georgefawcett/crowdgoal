Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'events#index'

  # get '/events/new' => 'events#new'
  # post '/events/new' => 'events#create'

  resources :events

  get '/register' => 'users#new'
  post '/register' => 'users#create'

  get '/tests/new' => 'tests#new'
  post '/tests/new' => 'tests#create'

 root to: "photos#index"
  resources :photos

end
