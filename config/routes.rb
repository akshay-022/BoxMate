Rottenpotatoes::Application.routes.draw do
  resources :chefmeals
  resources :customermeals
  resources :customerinfos
  resources :chefinfos

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/signIn')
  get '/signIn' => 'commons#signIn', as: 'commons'
  post '/signIn/signin_intermediate' => 'commons#signin_intermediate', as: 'signin'
  get '/customerinfo' => 'customerinfos#customer_homepage'
  put '/chefinfos/:id/update'=> "chefinfos#update", as: 'update_chefinfo'
  put '/chefinfos/:id/destroy_entry'=> "chefinfos#destroy_entry", as: 'destroy_chefinfo_entry'
  get '/chefinfos/:id/choose_entry'=> "chefinfos#choose_entry", as: 'choose_chefinfo_entry'
  put '/customerinfos/:id/update'=> "customerinfos#update", as: 'update_customerinfo'
  put '/customerinfos/:id/destroy_entry'=> "customerinfos#destroy_entry", as: 'destroy_customerinfo_entry'
  get '/customerinfos/:id/choose_entry'=> "customerinfos#choose_entry", as: 'choose_customerinfo_entry'
end
