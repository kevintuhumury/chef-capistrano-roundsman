def execute_rake(task, path)
  run "cd #{path} && bundle exec rake RAILS_ENV=#{rails_env} #{task}", env: { "RAILS_ENV" => rails_env }
end

def file_exists?(path)
  "true" ==  capture("if [ -e #{path} ]; then echo 'true'; fi").strip
end
