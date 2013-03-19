# since we're deploying a rails app, we need to precompile the assets.
load "deploy/assets"

set :application, "nginx-rails"
set :stage,       application

set :scm,         :git
set :branch,      "master"
set :repository,  "git@github.com:<yourname>/<example>.git"
set :deploy_via,  :remote_cache

set :sites,       ["#{application}.com"]

# NOTE: for some reason the server_root_password and password attributes can't
# be set directly in this file. So, those attributes will be set in the mysql
# recipe by applying the below temporary variables: root_passwd and passwd.

set :mysql,       root_passrd: "<server_root_password>",
                  database:    "<database>",
                  username:    "<username>",
                  passwd:      "<password>"

set :logrotate,   logs: ["#{deploy_to}/current/log/production.log"]

before "deploy:update_code" do
  roundsman.run_list "recipe[default::default]", "recipe[default::mysql]"
end

after "deploy:create_symlink" do
  roundsman.run_list "recipe[default::nginx]"
end

after "deploy:finalize_update", "app:symlink"

namespace :app do
  desc "symbolic link to the shared assets"
  task :symlink, roles: :app do
    symlink_shared_config "database.yml"
  end
end
