HomeManager::Application.routes.draw do
  
  resources :families

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

  resources :sessions
  
  root :to => 'home#index'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  match '/auth/facebook/callback' => 'sessions#create'
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/chores' => 'tasks#chores'
  match '/complete_task' => 'completions#complete_task', :as => :complete_task
  match '/make_parent' => 'family_members#make_parent', :as => :make_parent
  match '/buy_item' => 'purchases#buy_item', :as => :buy_item
  match '/award_credits' => 'users#award_credits', :as => :award_credits
end