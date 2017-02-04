CzardomMap::Engine.routes.draw do
  root to: 'regions#index'
  resources :regions, only: [:index] do
    member { get :users }
  end

  get '/:id', to: 'regions#index'
end
