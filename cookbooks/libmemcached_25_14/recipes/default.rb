#
# Cookbook Name:: libmemcached_25_14
# Recipe:: default
#

execute "install-libmemcached-0.25.14" do
  command %Q{
    cd /tmp
    tar xvzf /data/unix/libmemcached-0.25.14.tar.gz
    cd libmemcached-0.25.14
    ./configure && make && make install
  }
  not_if { File.exists?("/usr/local/lib/libmemcached.so") }
end

execute "install-memcached-0.13.gem" do
  command %Q{
    cd /data/gems
    gem install memcached-0.13.gem --no-rdoc --no-ri
  }
  not_if "gem list | grep 'memcached (0.13)'"
end

link "/data/climate_culture_app/current/config/memcached.yml" do
  to "/data/climate_culture_app/shared/config/memcached.yml"
end if File.exists?("/data/climate_culture_app/shared/config/memcached.yml")