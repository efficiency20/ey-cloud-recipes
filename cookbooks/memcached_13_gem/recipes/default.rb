#
# Cookbook Name:: memcached_13_gem
# Recipe:: default
#

execute "install-memcached-0.13.gem" do
  command "cd /data/gems && gem install memcached-0.13.gem --no-rdoc --no-ri"
  not_if "gem list | grep 'memcached (0.13)'"
end

link "/data/climate_culture_app/current/config/memcached.yml" do
  to "/data/climate_culture_app/shared/config/memcached.yml"
end if File.exists?("/data/climate_culture_app/shared/config/memcached.yml")