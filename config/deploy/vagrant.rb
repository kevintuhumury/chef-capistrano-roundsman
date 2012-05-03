set :stage,                 "vagrant"
set :main_server,           "192.168.1.10"
set :application_directory, "<application>"

set :url,                   main_server
set :email,                 "<email>"

set :user,                  "vagrant"
set :password,              "vagrant"
set :deploy_to,             "/var/www/#{application_directory}"

set :rails_env,             "production"
set :ruby_version,          "1.9.3-p194"

set :passenger,             :version => "3.0.12"
set :mysql,                 :server_root_password => "<server_root_password>",
                            :database => "<database>",
                            :username => "deploy",
                            :password => "<password>"
set :logrotate,             :logs => ["#{deploy_to}/current/log/production.log"]

server "#{main_server}",    :web, :app, :db, :primary => true
