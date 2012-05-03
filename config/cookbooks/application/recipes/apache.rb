include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_headers"
include_recipe "passenger_apache2::mod_rails"

apache_module "expires"
apache_module "include"

apache_site "000-default" do
  enable false
end

url = node[:url] || fail("please set :url as a chef attribute")

template File.join(node[:apache][:dir], "sites-available", url) do
  source "apache.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :public => File.join(node[:current_path], "public"),
    :application => node[:application],
    :email => node[:email],
    :url => url
  )
end

apache_site url
