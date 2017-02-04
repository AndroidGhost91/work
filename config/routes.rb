require 'sidekiq/web'

Rails.application.routes.draw do

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"

  authenticated do
    root to: 'boards#feed', as: :authenitcated_root
  end

  root to: 'pages#home'

  resources :comments

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  mount CzardomModels::Engine, at: '/'
  mount Payola::Engine, at: '/payments'
  mount CzardomAdmin::Engine, at: '/admin'
  mount CzardomMap::Engine, at: '/map'
  mount CzardomMessages::Engine, at: '/messages'
  mount CzardomEvents::Engine, at: '/calendar'

  get '/board', to: 'boards#board'
  get '/board/following', to: 'boards#following', as: :board_following
  get '/board/new', to: 'boards#new', as: :new_board
  post '/board', to: 'boards#create'
  post '/board/fetch_facebook_comments', to: 'boards#fetch_facebook_comments'
  get '/board/new_post', to: 'boards#new_post', as: :new_post_board
  get 'board/articles/:id', to: "boards#root_article", as: :article_board

  mount Forem::Engine, at: '/board'

  get '/preregister', to: 'pages#home'

  get '/earlybird', to: 'pages#earlybird'
  get '/complete', to: 'pages#complete'
  get '/thankyou', to: 'pages#thankyou'
  get '/express', to: 'pages#express'

  get '/pages/:id', to: 'pages#show'

  get '/account(/:id)/clients', to: 'users#edit_clients', as: :edit_user_clients
  get '/account(/:id)/groups', to: 'users#edit_groups', as: :edit_user_groups
  get '/account(/:id)/password', to: 'users#edit_password', as: :edit_password_user
  get '/account(/:id)', to: 'users#edit', as: :edit_user
  
  scope 'user', controller: :users do 
    match '/followed', action: 'followed', as: :user_followed, via: [:get, :post]
    match '/followers', action: 'followers', as: :user_followers, via: [:get, :post]
    get '/posts', action: 'posts', as: :user_posts
  end

  match '/czars', to: 'users#all_czars', via: [:get, :post]

  resources :tips, only: [:index]
  resources :special_offers, only: [:index]
  resources :notifications, only: [:index]

  resources :orders, only: [:new, :create]
  resources :users, only: [:new, :create, :show] do
    collection do
      get :blurbs
    end
  end
  resources :groups, only: [:index, :show, :edit, :update]

  namespace :onboarding do
    resources :groups, only: [:index, :show] do
      member { post :join; post :leave }
    end

    resources :clients, only: [:index]
  end

  get '/states_for_country', to: 'pages#states_for_country'

  get '/:id/image', to: 'users#image', as: :user_image
  #get '/:id', to: 'users#show', as: :user
  patch '/:id', to: 'users#update', as: :update_user
  
  match '/hooks/fb_created_callback'  => "hooks#fb_created_callback",via: [:get, :post]
  
  post 'users/follow/:user_id' => "users#follow", as: :user_follow
  post ':id/recommend' => "users#recommend", as: :user_recommend
  patch 'users/:id', to: 'users#update'
end
