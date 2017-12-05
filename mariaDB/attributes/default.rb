#
# MariaDB default config

default['mariadb']['mysqld']['user']			= 'mysql'
# default['mariadb']['mysqld']['pid_file']		= '/var/run/mysql' + \
#  '/mysqld.pid'
# default['mariadb']['mysqld']['socket']			= '/var/run/mysqld' + \
#  '/mysqld.sock'
default['mariadb']['mysqld']['port']                     = '3306'
default['mariadb']['mysqld']['basedir']                 = '/usr'
default['mariadb']['mysqld']['datadir']                 = '/var/lib/mysql'
default['mariadb']['mysqld']['tmpdir']                  = '/var/tmp'
default['mariadb']['mysqld']['lc_messages_dir']         = '/usr/share/mysql'
default['mariadb']['mysqld']['lc_messages']             = 'en_US'
default['mariadb']['mysqld']['skip_external_locking']   = 'true'
