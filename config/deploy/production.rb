load "deploy/assets"

set :application,           "<application>"
set :main_server,           "<server>"

set :stage,                 "#{application}-production"
set :application_directory, "#{application}"

set :scm,                   :git
set :branch,                "master"
set :repository,            "git@github.com:<yourname>/<example>.git"
set :deploy_via,            :remote_cache
set :copy_exclude,          [".git", ".gitignore"]

set :url,                   "<url>"
set :email,                 "<email>"

set :user,                  "<username>"
set :password,              "<password>"
set :deploy_to,             "/var/www/#{application_directory}"

set :rails_env,             "production"
set :ruby_version,          "1.9.3-p194"

set :passenger,             :version => "3.0.12"
set :mysql,                 :server_root_password => "<server_root_password>",
                            :database => "<database>",
                            :username => "<username>",
                            :password => "<password>"
set :logrotate,             :logs => ["#{deploy_to}/current/log/production.log"]

server "#{main_server}",    :web, :app, :db, :primary => true

before "deploy:update_code" do
  roundsman.run_list "recipe[application::default]", "recipe[application::mysql]"
end

after "deploy:create_symlink" do
  roundsman.run_list "recipe[application::apache]"
end
