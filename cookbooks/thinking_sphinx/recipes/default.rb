#
# Cookbook Name:: thinking_sphinx
# Recipe:: default
#
# Copyright 2008, Engine Yard, Inc.
#
# All rights reserved - Do Not Redistribute
#

if_app_needs_recipe("thinking_sphinx") do |app,data,index|
  
  http_request "reporting for sphinx" do
    url node[:reporting_url]
    message :message => "processing sphinx"
    action :post
    epic_fail true
  end
  
  require_recipe "monit"

  directory "/var/run/sphinx" do
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
  end

  directory "/var/log/engineyard/sphinx/#{app}" do
    owner node[:owner_name]
    group node[:owner_name]
    mode 0755
  end
  
  remote_file "/etc/logrotate.d/sphinx" do
    owner "root"
    group "root"
    mode 0755
    source "sphinx.logrotate"
    action :create
  end

  sphinx_service = find_app_service(app, "sphinx")
  
  monitrc "sphinx", :app_name => app,
                    :sphinx_service => sphinx_service
  
  template "/data/#{appname}/shared/config/sphinx.yml" do
    owner node[:owner_name]
    group node[:owner_name]
    mode 0644
    source "sphinx.yml.erb"
    variables({
      :app_name => app,
      :sphinx_service => sphinx_service
    })
    notifies :run, resources(:execute => "restart-monit")
    action :create_if_missing
  end
  
  link "/data/#{app}/current/config/sphinx.yml" do
    to "/data/#{app}/shared/config/sphinx.yml"
  end

  link "/data/#{app}/current/config/thinkingsphinx" do
    to "/data/#{app}/shared/config/thinkingsphinx"
  end
end
