Rails.application.routes.draw do
  post '/inbound_email', to: 'czardom_messages/email_parser#create'
end
