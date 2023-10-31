Rottenpotatoes::Application.routes.draw do
  resources :chefs
  resources :customers

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/signIn')
  get '/signIn' => 'commons#signIn', as: 'commons'
  post '/signIn/signin_intermediate' => 'commons#signin_intermediate', as: 'signin'
  get '/customer' => 'customers#customer_homepage'
end
