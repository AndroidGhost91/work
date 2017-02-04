CzardomMessages::Engine.routes.draw do
  root to: 'conversations#index'

  resources :conversations, only: [:index, :show, :new, :create] do
    resources :messages, only: [:show]

    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  post '/inbound_email', to: 'email_parser#create'
end
