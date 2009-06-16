#
# Cookbook Name:: libmemcached_25_14
# Recipe:: default
#

bash "install_something" do
user "root"
cwd "/tmp"
code <<-EOH
tar xzf /data/unix/libmemcached-0.25.14.tar.gz
cd libmemcached-0.25.14
/tmp/libmemcached-0.25.14/configure
make
make install
EOH
end

execute "ldconfig" do
  command "ldconfig"
end