set :rails_env, 'production'

server '104.236.215.243', user: 'deploy', roles: %w{web app db}
set :deploy_to, '/u/apps/czardom_qa'
set :whenever_identifier, ->{ "#{fetch(:application)}_qa" }
