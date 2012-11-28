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
  match '/complete_task' => 'completions#complete_task', :as => :complete_task
end