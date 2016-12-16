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
    resources :completions do
      collection do
        get 'who'
      end
    end
  end

  resources :users do
    collection do
      get 'multi'
      get 'allowance'
      get 'social_medium'
    end
    member do
      get 'toggle'
      get 'signup'
    end
    resources :tasks
    resources :completions
    resources :purchases
    resources :events
    resources :social_medium do
      collection do
        get 'relationships'
        get 'instagram_post'
        get 'delete_comment'
        get 'unfollow'
        get 'block_user'
        get 'twitter_post'
        get 'more_results'
        get 'record'
      end
      member do
        get 'disable'
      end
    end
  end

  resources :events

  resources :activities

  resources :sessions

  resources :registrations
  post "registrations/hook"

  resources :instagram do
    collection do
      get 'connect'
      get 'callback'
    end
  end

  resources :twitter do
    collection do
      get 'connect'
      get 'callback'
    end
  end
  get '/auth/twitter/callback' => 'twitter#callback'

  resources :google do
    collection do
      get 'connect'
      get 'callback'
    end
  end
  get '/auth/google_oauth2/callback' => 'google#callback'

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

  resources :pinterest do
    collection do
      get 'connect'
      get 'callback'
    end
  end
  get '/auth/pinterest/callback' => 'pinterest#callback'

  root :to => 'home#index'

  get '/administration', to: 'users#index', as: :admin
  get '/family', to: 'families#show'
  get '/profile', to: 'users#show'
  get '/member/:id', to: 'users#show', as: :member
  get '/my_family/:url', to: 'families#my_family', as: :my_family
  get '/signup', to: 'users#signup', as: 'signup'
  post '/register', to: 'users#register', as: 'register'
  get '/activate', to: 'registrations#new', as: 'activate'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/auth/facebook/callback' => 'sessions#create'
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/chores' => 'tasks#chores'
  get '/complete_task' => 'completions#complete_task', :as => :complete_task
  get '/who' => 'completions#who', :as => 'who'
  get '/make_parent' => 'family_members#make_parent', :as => :make_parent
  get '/buy_item' => 'purchases#buy_item', :as => :buy_item
  get '/award_credits' => 'users#award_credits', :as => :award_credits
  get '/assign_meal' => 'meals#assign_meal', :as => :assign_meal
  get '/privacy' => 'home#privacy_policy', :as => :privacy
  get '/save_feed' => 'social_medium#save_feed', :as => :save_feed

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
