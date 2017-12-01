#
# Cookbook:: mariaDB
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute "update-upgrade" do
        command "apt-get update && apt-get upgrade -y"
        action :run
end

# Install MariaDB Server
package "mariadb-server" do
	action :install
end

# Update main MariaDB Server configuration file using Chef template file
template "/etc/mysql/mariadb.conf.d/50-server.cnf" do
	source "50-server.cnf.erb"
	owner "root"
	group "root"
	mode 0644
	variables(:allow_override => "All")
	notifies :restart, "service[mysql]"
end

# Start mariadb service
service "mysql" do
  supports :status => true, :restart => true, :start => true
  action [ :start,  :enable]
end

# Install expect utility
package "expect" do
	action :install
end

# Run command to configure MariaDB security settings post installation
bash "mysql_secure_installation" do
  user "root"
  code <<-EOF
  /usr/bin/expect -c 'spawn /usr/bin/mysql_secure_installation
  expect "Enter current password for root (enter for none):"
  send  "\r"
  expect "Change root password?"
  send "y"
  expect "New password:"
  send "secret"
  expect "Re-enter new password:"
  send "secret"
  expect "Remove anonymous users?"
  send "y"
  expect "Disallow root login remotely?"
  send "y"
  expect "Remove test database and access to it?"
  send "y"
  expect "Reload privilege tables now?"
  send "y" eof'
  EOF
end
