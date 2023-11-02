Rottenpotatoes::Application.routes.draw do
  resources :chefs
  resources :customers

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/signIn')
  get '/signIn' => 'commons#signIn', as: 'commons'
  post '/signIn/signin_intermediate' => 'commons#signin_intermediate', as: 'signin'
  get '/customer' => 'customers#customer_homepage'
  put '/chefs/:id/update'=> "chefs#update", as: 'update_chef'
  put '/chefs/:id/destroy_entry'=> "chefs#destroy_entry", as: 'destroy_entry'
  get '/chefs/:id/choose_entry'=> "chefs#choose_entry", as: 'choose_entry'
  put '/customers/:id/update'=> "customers#update", as: 'update_customer'
  put '/customers/:id/destroy_entry'=> "chefs#destroy_entry", as: 'destroy_customer_entry'
  get '/customers/:id/choose_entry'=> "chefs#choose_entry", as: 'choose_customer_entry'
end
