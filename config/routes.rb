HomeManager::Application.routes.draw do
  
  resources :completions

  resources :tasks do
    resources :completions
  end

  resources :users do
    resources :tasks
    resources :completions
  end

  root :to => 'home#index'

  match '/auth/facebook/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout

  match '/chores' => 'tasks#chores'

end