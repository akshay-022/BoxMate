Rottenpotatoes::Application.routes.draw do
  resources :chefmeals
  resources :customermeals
  resources :customerinfos
  resources :chefinfos

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/signIn')
  get '/signIn' => 'commons#signIn', as: 'commons'
  post '/signIn/signin_intermediate' => 'commons#signin_intermediate', as: 'signin'
  get '/signup/chef' => 'commons#signup_chef', as: 'signup_chef'
  get '/signup/customer' => 'commons#signup_customer', as: 'signup_customer'
  post '/signup/chef/intermediate' => 'commons#signup_chef_intermediate', as: 'signup_chef_intermediate'
  post '/signup/customer/intermediate' => 'commons#signup_customer_intermediate', as: 'signup_customer_intermediate'
  get '/customerinfo' => 'customerinfos#customer_homepage'
  put '/chefinfos/:id/update'=> "chefinfos#update", as: 'update_chefinfo'
  put '/chefinfos/:id/destroy_entry'=> "chefinfos#destroy_entry", as: 'destroy_chefinfo_entry'
  get '/chefinfos/:id/choose_entry'=> "chefinfos#choose_entry", as: 'choose_chefinfo_entry'
  put '/customerinfos/:id/update'=> "customerinfos#update", as: 'update_customerinfo'
  put '/customerinfos/:id/destroy_entry'=> "customerinfos#destroy_entry", as: 'destroy_customerinfo_entry'
  get '/customerinfos/:id/choose_entry'=> "customerinfos#choose_entry", as: 'choose_customerinfo_entry'
  get '/chefinfos/:id/see_meal'=> "chefinfos#see_meal", as: 'see_meal'
  delete '/logout' => 'commons#destroy', as: 'logout'
end
