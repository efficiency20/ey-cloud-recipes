execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

require_recipe 'libmemcached_25_14'
require_recipe 'thinking_sphinx'
require_recipe 'climateculture_config'

# uncomment if you want to run couchdb recipe
# require_recipe "couchdb"

# uncomment to turn your instance into an integrity CI server
#require_recipe "integrity"

# uncomment to turn use the MBARI ruby patches for decreased memory usage and better thread/continuationi performance
# require_recipe "mbari-ruby"