HomeManager::Application.routes.draw do
  
  resources :meals

  resources :families do
    collection do
      get 'multi'
    end
    resources :tasks
  end

  resources :items do 
    resources :purchases
  end

  resources :purchases

  resources :completions

  resources :tasks do
    resources :completions
  end

  resources :users do
    collection do
      get 'multi'
      get 'allowance'
    end
    resources :tasks
    resources :completions
    resources :purchases
    resources :events
    resources :social_medium do
      collection do
        get 'relationships'
      end
    end
  end

  resources :events

  resources :activities

  resources :sessions

  resources :instagram do
    collection do 
      get 'connect'
      get 'callback'
    end
  end

  resources :facebook do
    collection do 
      get 'connect'
      get 'callback'
    end
  end

  resources :tumblr do
    collection do
      get 'callback'
    end
  end
  get '/auth/tumblr/callback' => 'tumblr#callback'
  
  root :to => 'home#index'

  get '/my_family/:url', to: 'families#my_family', as: :my_family
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/auth/facebook/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/chores' => 'tasks#chores'
  get '/complete_task' => 'completions#complete_task', :as => :complete_task
  get '/make_parent' => 'family_members#make_parent', :as => :make_parent
  get '/buy_item' => 'purchases#buy_item', :as => :buy_item
  get '/award_credits' => 'users#award_credits', :as => :award_credits
  get '/assign_meal' => 'meals#assign_meal', :as => :assign_meal
end