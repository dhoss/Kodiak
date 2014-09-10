# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{deploy@localhost}
role :web, %w{deploy@localhost}
role :db,  %w{deploy@localhost}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server 'localhost', user: 'deploy', roles: %w{web app}, my_property: :my_value


set :app_name, "kodiak-development"
set :user, "deploy"

namespace :foreman do
  desc "Export the Procfile to Debian's startup scripts"
  task :export, :roles => :app do
    run "cd #{current_path} && #{sudo} bundle exec foreman export initscript /etc/init.d"
  end

  desc "Start the application services"
  task :start, :roles => :app do
    run "#{sudo} service #{app_name} start"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    run "#{sudo} service #{app_name} stop"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "#{sudo} service #{app_name} start || #{sudo} service #{app_name} restart"
  end
end

namespace :deploy do
  task :restart, :roles => :app do
    foreman.export

    run "(kill -s SIGUSR1 $(ps -C ruby -F | grep '/puma' | awk {'print $2'})) || #{sudo} service #{app_name} restart"

    #foreman.restart # uncomment this (and comment line above) if we need to read changes to the procfile
  end
end

namespace :setup do

  desc "Upload database.yml file."
  task :upload_yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
    end
  end

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Symlinks config files for Nginx"
  task :symlink_config do
    on roles(:app) do
      execute "rm -f /etc/nginx/sites-enabled/default"

      execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
   end
  end

end
