HomeManager::Application.routes.draw do
  
  resources :users

  root :to => 'home#index'

  match '/auth/facebook/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout

end