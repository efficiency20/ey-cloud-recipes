#
# Cookbook Name:: climateculture_config
# Recipe:: default
#

app = 'climate_culture_app'

bash "monit-stop-all" do
  user "root"
  code "/usr/bin/monit stop all"
end

require_recipe 'lockrun'
require_recipe 'memcached_gem'
require_recipe 'ar_mailer_gem'
require_recipe 'GeoRuby_gem'
require_recipe 'thinking_sphinx'
require_recipe 'delayed_job'

link "/data/#{app}/current/config/facebooker.yml" do
  to "/data/#{app}/shared/config/facebooker.yml"
end if File.exists?("/data/#{app}/shared/config/facebooker.yml")

link "/data/#{app}/current/public/user_photos" do
  to "/data/#{app}/shared/public/user_photos"
end if File.directory?("/data/#{app}/shared/public/user_photos")

link "/data/#{app}/current/public/attachments" do
  to "/data/#{app}/shared/public/attachments"
end if File.directory?("/data/#{app}/shared/public/attachments")

execute "copy api.rb" do
  command "cp -p /data/#{app}/shared/config/initializers/api.rb /data/#{app}/current/config/initializers/api.rb"
end if File.exists?("/data/#{app}/shared/config/initializers/api.rb")

execute "copy staging.rb" do
  command "cp -p /data/#{app}/shared/config/environments/staging.rb /data/#{app}/current/config/environments/staging.rb"
end if File.exists?("/data/#{app}/shared/config/environments/staging.rb")

execute "install climate_culture_app custom gems" do
  command "cd /data/#{app}/current && rake gems:build_and_install"
end

execute "generate thinking-sphinx conf and index" do
  command %Q{
    cd /data/#{app}/current \
    rake RAILS_ENV=#{@node[:environment][:framework_env]} ts:conf && \
    rake RAILS_ENV=#{@node[:environment][:framework_env]} ts:index}
end

execute "ensure sphinx index permissions" do
  command "chown -R #{node[:owner_name]}:#{node[:owner_name]} /var/log/engineyard/sphinx/#{app}"
end

bash "monit-reload-restart" do
  user "root"
  code "/usr/bin/monit reload && /usr/bin/monit start all"
  #code "pkill -9 monit && monit"
end
