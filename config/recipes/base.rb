def symlink_shared_config(file)
  if file_exists? "#{shared_path}/#{file}"
    run "ln -sf #{shared_path}/#{file} #{release_path}/config/#{file}"
  end
end

def build_middleman
  run "cd #{release_path}; bundle exec middleman build"
end
