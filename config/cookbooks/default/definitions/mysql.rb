define :mysql do
  execute "performing query #{params[:name]}" do
    password = params[:password] ? "--password='#{params[:password]}'" : ""
    user = params[:user] || "root"
    command %|mysql -u #{user} #{password} -e "#{params[:query]}"|
  end
end
