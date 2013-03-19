include_recipe "nginx::source"
include_recipe "nginx::passenger"

nginx_site "000-default" do
  enable false
end

sites = node[:sites] || fail("please set :sites as a chef attribute")

sites.each do |url|
  template File.join(node[:nginx][:dir], "sites-available", url) do
    source "nginx.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      public:      File.join(node[:current_path], "public"),
      application: node[:application],
      url:         url
    )
  end

  nginx_site url
end
