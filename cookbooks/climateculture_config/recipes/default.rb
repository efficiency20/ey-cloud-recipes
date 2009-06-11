#
# Cookbook Name:: climateculture_config
# Recipe:: default
#

node[:applications].each do |app,data|
  next unless app == 'climate_culture_app'

  link "/data/#{app}/current/config/memcached.yml" do
    to "/data/#{app}/shared/config/memcached.yml"
  end

  link "/data/#{app}/current/config/facebooker.yml" do
    to "/data/#{app}/shared/config/facebooker.yml"
  end

  execute "copy api.rb" do
    command "cp /data/#{app}/shared/config/initializers/api.rb /data/#{app}/current/config/initializers/api.rb"
  end
end