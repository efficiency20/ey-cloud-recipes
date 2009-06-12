#
# Cookbook Name:: libmemcached_25_14
# Recipe:: default
#

execute "install-libmemcached-0.25.14" do
  command %Q{
    cd /tmp &&
    tar xvzf /data/unix/libmemcached-0.25.14.tar.gz &&
    cd libmemcached-0.25.14 &&
    ./configure && make && make install
  }
  not_if { File.exists?("/usr/local/lib/libmemcached.so") }
end
