# Class: crossover_icinga
#
# This module manages crossover_icinga
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class crossover_icinga (
#class crossover_icinga () {

$icinga_root_mysql_passwd = $crossover_icinga::params::icinga_root_mysql_passwd,
$class_epel = $crossover_icinga::params::class_epel,
$class_icinga = $crossover_icinga::params::class_icinga,
$class_mysql_server =  $crossover_icinga::params::class_mysql_server,
$class_apache = $crossover_icinga::params::class_apache,
$class_apache_mod_php = $crossover_icinga::params::class_apache_mod_php,
$icinga_mysql_name = $crossover_icinga::params::icinga_mysql_name,
$icinga_mysql_user = $crossover_icinga::params::icinga_mysql_user,
$icinga_mysql_passwd = $crossover_icinga::params::icinga_mysql_passwd,
$icinga_mysql_host = $crossover_icinga::params::icinga_mysql_host,
$icinga_mysql_grant = $crossover_icinga::params::icinga_mysql_grant,
$uninstall_package_name = $crossover_icinga::params::uninstall_package_name,
$uninstall_options = $crossover_icinga::params::uninstall_options,
$uninstall_packages = $crossover_icinga::params::uninstall_packages,
$package_icinga2_classicgui = $crossover_icinga::params::package_icinga2_classicgui,
$package_icinga_gui = $crossover_icinga::params::package_icinga_gui,
$package_nagios_plugins = $crossover_icinga::params::package_nagios_plugins,
$usermod_icingauser = $crossover_icinga::params::usermod_icingauser,
$usermod_icingauser_command = $crossover_icinga::params::usermod_icingauser_command,
$icinga_host_file = $crossover_icinga::params::icinga_host_file,
$icinga_host_file_source = $crossover_icinga::params::icinga_host_file_source,
$icinga_command_file = $crossover_icinga::params::icinga_command_file,
$icinga_command_file_source = $crossover_icinga::params::icinga_command_file_source,
$icinga_service_file = $crossover_icinga::params::icinga_service_file,
$icinga_service_file_source = $crossover_icinga::params::icinga_service_file_source,
$restart_apache = $crossover_icinga::params::restart_apache,
$restart_icinga2 = $crossover_icinga::params::restart_icinga2,
$disable_selinu = $crossover_icinga::params::disable_selinu,


) inherits crossover_icinga::params{



############### Installing Icinga Server ######

class{$class_epel:}


class{$class_icinga:
  initdb           => true,
  with_classicui   => true,
  enabled_features => ['statusdata', 'compatlog', 'command'],
}


class { $class_mysql_server:
  root_password           => $icinga_root_mysql_passwd,
  remove_default_accounts => true,
  override_options        => $override_options
}

class {$class_apache:
  purge_configs => false,   
}


class {$class_apache_mod_php: }

mysql::db { $icinga_mysql_name:
  user     => $icinga_mysql_user,
  password => $icinga_mysql_passwd,
  host     => $icinga_mysql_host,
  grant    => [$icinga_mysql_grant],
}

##### Unistall icinga-config-gui
package { $uninstall_package_name:
  ensure            => absent,
  uninstall_options => [ { $uninstall_options => $uninstall_packages } ],
}

### Install icinga2-classicui-config icinga-gui for the Classic GUI, you can login with credentials icingaadmin:icingaadmin

package { $package_icinga2_classicgui:
  #require => Exec['updates'],        # require 'update' before installing
  ensure => installed,
}

package { $package_icinga_gui:
  #require => Exec['updates'],        # require 'update' before installing
  ensure => installed,
}

### La BD para Icinga mysql -u root -p icinga < /usr/share/icinga2-ido-mysql/schema/mysql.sql

### Installing nagios-plugins-all for icinga
package { $package_nagios_plugins:
  #require => Exec['updates'],        # require 'update' before installing
  ensure => installed,
}


######## Creating folder in icinga server /opt/icinga_conf

    file { '/opt/icinga_conf':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }


####### Adding Icingacmd user to apache: usermod –g icingacmd apache

exec { $usermod_icingauser:
    command => $usermod_icingauser_command,
}

#######  Copy files to icinga conf

  file {
    $icinga_host_file:
    ensure => file,
    backup  => true,
    source => $icinga_host_file_source,
  }

  file {
    $icinga_command_file:
    ensure => file,
    backup  => true,
    source => $icinga_command_file_source,
  }

  file {
    $icinga_service_file:
    ensure => file,
    backup  => true,
    source => $icinga_service_file_source,
  }

## Restart Icinga and Apache

exec { 'Restart_Apache':
    command => $restart_apache,
}

exec { 'Restart_Icinga2':
    command => $restart_icinga2,
}

## Disable Selinux
exec { 'disable_selinux':
    command => $disable_selinu,
}


}# End class crossover_icinga
