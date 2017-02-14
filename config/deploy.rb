# config valid only for current version of Capistrano
lock '3.4.0'

namespace :deploy do
  # desc "start resque"
  # task "resque:start" => :app do
  #   run "cd #{current_path} && RAILS_ENV=#{environment} BACKGROUND=yes PIDFILE=#{shared_path}/pids/resque.pid QUEUE=* nohup bundle exec rake environment resque:work QUEUE='*' >> #{shared_path}/log/resque.out"
  # end

  # desc "stop resque"
  # task "resque:stop" => :app do
  #   run "kill -9 `cat #{shared_path}/pids/resque.pid`"
  # end

  # desc "ReStart resque"
  # task "resque:restart" => :app do
  #   Rake::Task['deploy:resque:stop'].invoke
  #   Rake::Task['deploy:resque:start'].invoke
  # end

  # desc "start resque scheduler"
  # task "resque:start_scheduler" => :app do
  #   run "cd #{current_path} && RAILS_ENV=#{environment} DYNAMIC_SCHEDULE=true BACKGROUND=yes PIDFILE=#{shared_path}/pids/resque_scheduler.pid QUEUE=* nohup bundle exec rake environment resque:scheduler >> #{shared_path}/log/resque_scheduler.out"
  # end

  # desc "stop resque scheduler"
  # task "resque:stop_scheduler" => :app do
  #   run "kill -9 `cat #{shared_path}/pids/resque_scheduler.pid`"
  # end

  # desc "ReStart resque scheduler"
  # task "resque:restart" => :app do
  #   Rake::Task['deploy:resque:stop_scheduler'].invoke
  #   Rake::Task['deploy:resque:start_scheduler'].invoke
  # end

 
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('sudo service nginx restart')
    end
  end

  after :publishing, :restart  
  # after :publishing, 'deploy:restart'
  # after :finishing, 'deploy:cleanup'
  # after "deploy:update_code", "deploy:migrate"


  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      execute :touch, 'sudo service nginx restart'
      # execute 'cd /home/ubuntu/Trusttd/current; RAILS_ENV=production bundle exec rake db:migrate'
      # execute 'cd /home/ubuntu/Trusttd/current; RAILS_ENV=development bundle install'
      # execute 'sudo service nginx restart'
    end
  end

end
