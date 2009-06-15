#
# Cookbook Name:: memcached_gem
# Recipe:: default
#

execute "install-memcached-gem" do
  command 'env ARCHFLAGS="-arch i386" gem install -r -V memcached --no-rdoc --no-ri'
  not_if "gem list | grep memcached"
end

link "/data/climate_culture_app/current/config/memcached.yml" do
  to "/data/climate_culture_app/shared/config/memcached.yml"
end if File.exists?("/data/climate_culture_app/shared/config/memcached.yml")