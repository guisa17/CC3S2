Myrottenpotatoes::Application.routes.draw do
  resources :movies
  resources :sessions, only: [:new, :create, :destroy]
  
  #routes.rb
  get  'auth/:provider/callback' => 'sessions#create'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/twitter', :as => 'login'
  post 'logout' => 'sessions#destroy'

  root :to => redirect('/movies')
end
