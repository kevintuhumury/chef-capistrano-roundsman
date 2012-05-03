set :stages,              %w(vagrant production)
set :default_stage,       "production"

set :application,         "<application>"
set :cookbooks_directory, ["config/cookbooks", "vendor/cookbooks"]

set :scm,                 :git
set :branch,              "master"
set :repository,          "git@github.com:<yourname>/<example>.git"
set :deploy_via,          :remote_cache
set :use_sudo,            false
set :keep_releases,       10

set :default_run_options, :pty => true
set :ssh_options,         :forward_agent => true

before "deploy:update_code" do
  roundsman.run_list "recipe[application::default]", "recipe[application::mysql]"
end

after "deploy:finalize_update", "app:symlink"
after "deploy:update_code",     "app:remove_rvmrc"
after "deploy",                 "deploy:cleanup"

after "deploy:create_symlink" do
  roundsman.run_list "recipe[application::apache]"
end

namespace :deploy do
  [:start, :stop].each do |task|
    desc "#{task} task is a no-op with passenger"
    task task, :roles => :app do ; end
  end

  desc "restart passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :app do
  desc "symbolic link to the shared assets"
  task :symlink, :roles => [:app] do
    run "ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"
  end

  desc "remove rvmrc"
  task :remove_rvmrc, :roles => [:app] do
    run "rm #{release_path}/.rvmrc"
  end
end
