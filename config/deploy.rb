load "config/recipes/base"
load "config/recipes/formatting"
load "config/recipes/helpers"

server "<server>",          :web, :app, :db, primary: true

set :stages,                %w(apache-rails nginx-rails nginx-middleman vagrant)
set :cookbooks_directory,   %w(config/cookbooks vendor/cookbooks)
set :application_directory, defer { application }
set :deploy_to,             defer { "/var/www/#{application_directory}" }

set :user,                  "<username>"
set :password,              "<password>"
set :copy_exclude,          [".git", ".gitignore", ".DS_Store", ".rvmrc"]

set :rails_env,             "production"
set :ruby_version,          "1.9.3-p392"
set :chef_version,          "11.2.0"

set :use_sudo,              false
set :default_run_options,   pty: true
set :ssh_options,           forward_agent: true
set :keep_releases,         10

before "bundle:install",    "app:update_current_release"

after "deploy:update_code", "deploy:cleanup"

namespace :deploy do
  [:start, :stop].each do |task|
    desc "#{task} task isn't needed with passenger"
    task task, roles: :app do ; end
  end

  desc "restart passenger"
  task :restart, roles: :app, except: { no_release: true } do
    run "touch #{File.join(current_path, 'tmp/restart.txt')}"
  end
end

namespace :app do
  desc "builds a middleman app"
  task :middleman, roles: :app do
    build_middleman
  end

  desc "update the current_release path"
  task :update_current_release, roles: :app do
    set :current_release, release_path
  end
end
