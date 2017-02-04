Rails.application.routes.draw do
  get '/regions', to: 'czardom_events/regions#index', defaults: { format: :json }
  
  get '/events', to: 'czardom_events/events#index'
end
