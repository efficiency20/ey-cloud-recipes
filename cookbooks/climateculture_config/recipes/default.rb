#
# Cookbook Name:: climateculture_config
# Recipe:: default
#

app = 'climate_culture_app'

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

execute "install climate_culture_app custom gems" do
  command %Q{
    cd /data/#{app}/current && \
    rake gems:build_and_install }
end

execute "generate thinking-sphinx conf and index" do
  command %Q{
    cd /data/#{app}/current \
    rake RAILS_ENV=#{@node[:environment][:framework_env]} ts:conf && \
    rake RAILS_ENV=#{@node[:environment][:framework_env]} ts:index}
end

execute "fix sphinx permissions" do
  command "chown -R #{node[:owner_name]}:#{node[:owner_name]} /var/log/engineyard/sphinx/#{app}"
end

execute "install climate_culture_app custom monit scripts" do
  command "cp -p /data/monit.d/*.monitrc /etc/monit.d/"
end if File.directory?("/etc/monit.d/")

execute "monit-stop-all" do
  command "/usr/bin/monit stop all"
end

execute "monit-reload" do
  command "/usr/bin/monit reload"
end

execute "monit-start-all" do
  command "/usr/bin/monit start all"
end