# since we're deploying a non-rails app, there is no need to precompile the assets.

set :application, "nginx-middleman"
set :stage,       application

set :scm,         :git
set :branch,      :master
set :repository,  "git@github.com:<yourname>/<example>.git"
set :deploy_via,  :remote_cache

set :sites,       ["#{application}.com"]

before "deploy:update_code" do
  roundsman.run_list "recipe[default::nginx]"
end

after "bundle:install", "app:middleman"
