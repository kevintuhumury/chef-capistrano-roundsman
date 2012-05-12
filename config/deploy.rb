set :stages,              %w(vagrant production)
set :cookbooks_directory, ["config/cookbooks", "vendor/cookbooks"]

set :use_sudo,            false
set :keep_releases,       10

set :default_run_options, :pty => true
set :ssh_options,         :forward_agent => true

before "bundle:install", "app:update_current_release"

after "deploy:finalize_update", "app:symlink"
after "deploy:update_code",     "app:remove_rvmrc"
after "deploy",                 "deploy:cleanup"

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

  desc "update the release path, since it's using the previous one"
  task :update_current_release do
    set :current_release, release_path
  end

  desc "remove rvmrc"
  task :remove_rvmrc, :roles => [:app] do
    run "rm #{release_path}/.rvmrc" if file_exists? "#{release_path}/.rvmrc"
  end
end

def file_exists?(path)
  "true" ==  capture("if [ -e #{path} ]; then echo 'true'; fi").strip
end
