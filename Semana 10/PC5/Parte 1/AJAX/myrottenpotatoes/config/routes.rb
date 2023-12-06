Myrottenpotatoes::Application.routes.draw do
  #resources :movies
  resources :movies do
  resources :reviews
end
  root :to => redirect('/movies')
end
