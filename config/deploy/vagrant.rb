# since we're deploying a rails app, we need to precompile the assets.
# as an example the nginx-rails app is being deployed to vagrant here.
load "deploy/assets"

set :host,        "192.168.33.10"
set :application, "nginx-rails"
set :stage,       "vagrant-#{application}"

set :scm,         :git
set :branch,      "master"
set :repository,  "git@github.com:<yourname>/<example>.git"
set :deploy_via,  :remote_cache

set :url,         ["#{application}.com"]

set :user,        "vagrant"
set :password,    "vagrant"

# NOTE: for some reason the server_root_password and password attributes can't
# be set directly in this file. So, those attributes will be set in the mysql
# recipe by applying the below temporary variables: root_passwd and passwd.

set :mysql,       root_passwd: "<server_root_password>",
                  database: "<database>",
                  username: "<username>",
                  passwd: "<password>"

set :logrotate,   logs: ["#{deploy_to}/current/log/production.log"]

server host,      :web, :app, :db, primary: true

before "deploy:update_code" do
  roundsman.run_list "recipe[default::default]", "recipe[default::mysql]"
end

after "deploy:create_symlink" do
  roundsman.run_list "recipe[default::nginx]"
end
