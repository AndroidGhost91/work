CzardomAdmin::Engine.routes.draw do
  root to: 'pages#dashboard'
  resources :sales, :products, :conversations, :regions, :tips, :special_offers

  resources :users do
    member do
      post :impersonate
    end
  end

  resources :events, except: :create do
    collection do
      post :index
    end
  end

  resources :slides do
    collection do
      post :update_position
    end
  end

  resources :root_articles
  
  resources :sponsor_logos
  
  resources :groups do
    member { post :create_board }
  end

  resources :subscription_plans
  
  post 'groups/:id/sponsors', to: "sponsor_logos#add_group_sponsor", as: :add_sponsor_to_group
end
