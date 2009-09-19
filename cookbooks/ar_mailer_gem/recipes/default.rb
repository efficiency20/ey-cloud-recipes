#
# Cookbook Name:: adzap-ar_mailer_gem
# Recipe:: default
#

execute "install-adzap-ar_mailer-gem" do
  command 'gem install -r -V adzap-ar_mailer --no-rdoc --no-ri --source http://gems.github.com'
  not_if "gem list | grep adzap-ar_mailer"
end