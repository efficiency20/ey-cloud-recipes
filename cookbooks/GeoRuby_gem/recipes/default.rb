#
# Cookbook Name:: GeoRuby_gem
# Recipe:: default
#

execute "install-GeoRuby-gem" do
  command 'env ARCHFLAGS="-arch i386" gem install -r -V GeoRuby --no-rdoc --no-ri'
  not_if "gem list | grep GeoRuby"
end