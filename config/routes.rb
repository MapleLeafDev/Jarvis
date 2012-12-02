HomeManager::Application.routes.draw do
  
  resources :items do 
    resources :purchases
  end

  resources :purchases

  resources :completions

  resources :tasks do
    resources :completions
  end

  resources :users do
    resources :tasks
    resources :completions
    resources :purchases
  end

  root :to => 'home#index'

  match '/auth/facebook/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/chores' => 'tasks#chores'
  match '/complete_task' => 'completions#complete_task', :as => :complete_task
  match '/buy_item' => 'purchases#buy_item', :as => :buy_item
  match '/award_credits' => 'users#award_credits', :as => :award_credits
end