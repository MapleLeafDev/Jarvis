HomeManager::Application.routes.draw do
  
  resources :tasks

  resources :users do
    resources :tasks
  end

  root :to => 'home#index'

  match '/auth/facebook/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout

end