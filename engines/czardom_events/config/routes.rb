CzardomEvents::Engine.routes.draw do
  root to: 'events#index'

  resources :events do
    collection do
      get :count_by_day
      post :follow, as: :event_follow
    end

    member do
      post :join
      post :leave
    end
  end

  get '/regions', to: 'regions#index', defaults: { format: :json }
end
