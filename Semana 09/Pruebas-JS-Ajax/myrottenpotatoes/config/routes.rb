Myrottenpotatoes::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  #resources :movies
  resources :movies do
  resources :reviews
end
  root :to => redirect('/movies')
end
