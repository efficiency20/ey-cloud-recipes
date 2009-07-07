#
# Cookbook Name:: delayed_job
# Recipe:: default
#

node[:applications].each do |app,data|
  next unless app == 'climate_culture_app'

  directory "/var/run/engineyard/dj/#{app}" do
    recursive true
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
  end

end
