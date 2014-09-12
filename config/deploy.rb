# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'kodiak'
set :repo_url, 'git@bitbucket.org:djaustin/stonecolddev.in.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/kodiak'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

set :linked_files, %w{config/database.yml config/application.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# Puma settings
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_init_active_record, true
set :puma_preload_app, true
set :rvm1_ruby_version, "2.0.0"

namespace :setup do
  desc "Set up directories"
  task :setup_directories do
    on roles(:app) do
      execute :sudo, "mkdir -p /var/www/kodiak"
      execute :sudo, "chown -hR deploy:www-data /var/www/kodiak"
      execute :sudo, "chmod 0755 /var/www/kodiak"
    end
  end
  
  desc "Set up database"
  task :setup_db do
    on roles(:app) do
      with rails_env: :production do
        execute :rake, "db:create"
      end
      execute( "psql -Upostgres < db/create_kodiak_users.sql" )
      execute( "psql -Upostgres < db/search_extensions.sql" )
    end
  end

  desc "Upload database.yml file."
  task :upload_db_config do
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

  desc "Install packages"
  task :install_packages do
    on roles(:app) do
      execute :sudo, "apt-get install wget ca-certificates"
      execute "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -"
      execute :sudo, 'sh -c "echo \'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main 9.3\' >> /etc/apt/sources.list.d/pgdg.list"' 
      execute :sudo, "apt-get update"
      execute :sudo, "apt-get install postgresql-contrib-9.3 postgresql-9.3 git-core build-essential curl -y"
    end
  end
end

namespace :deploy do

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

  after :finishing, "deploy:cleanup"

end
