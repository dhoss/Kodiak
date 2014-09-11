role :app, %w{deploy@stonecolddev.in}
role :web, %w{deploy@stonecolddev.in}
role :db,  %w{deploy@stonecolddev.in}

server 'stonecolddev.in', user: 'deploy', roles: %w{web app}

set :ssh_options, {
  keys: %w(/home/devin/.ssh/id_rsa),
  forward_agent: false,
  auth_methods: %w(publickey),
  port: 1023
}
