#
# Cookbook:: mariaDB
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute "update-upgrade" do
        command "apt-get update && apt-get upgrade -y"
        action :run
end

package "mariadb-server"

# Start mariadb service
service "mysql" do
  supports :status => true, :restart => true, :start => true
  action [ :start,  :enable]
end

package "expect"

bash "mysql_secure_installation" do
  user "root"
  code <<-EOF
  /usr/bin/expect -c 'spawn /usr/bin/mysql_secure_installation
  expect "Enter current password for root (enter for none):"
  send  "\r"
  expect "Change root password?"
  send "y\n"
  expect "New password:"
  send "root\n"
  expect "Re-enter new password:"
  send "root\n"
  expect "Remove anonymous users?"
  send "y\n"
  expect "Disallow root login remotely?"
  send "y\n"
  expect "Remove test database and access to it?"
  send "y\n"
  expect "Reload privilege tables now?"
  send "y\n" eof'
  EOF
end
