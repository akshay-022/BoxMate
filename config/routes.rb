Rottenpotatoes::Application.routes.draw do
  resources :movies
  resources :chefs
  resources :customers
  # map '/' to be a redirect to '/movies'
  #root :to => redirect('/movies')
  root :to => redirect('/signIn')
  get '/signIn' => 'commons#signIn'
end
