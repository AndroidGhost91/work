CzardomModels::Engine.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/users/sessions/new', to: 'sessions#new', as: :new_user_session

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', passwords: 'users/passwords' }, skip: [:sessions]

  devise_scope :user do
    delete "/logout" => "sessions#destroy", as: :destroy_user_session
    get "/logout" => "sessions#destroy", as: :destroy_user_session2
  end

end
