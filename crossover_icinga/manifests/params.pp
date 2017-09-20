class crossover_icinga::params {

  case $::osfamily {
    'Debian':  {
       $icinga_root_mysql_passwd = 'Tempor@l'
       $class_epel = '::epel'
       $class_icinga = '::icinga'
       $class_mysql_server =  '::mysql::server'
       $class_apache = 'apache'
       $class_apache_mod_php = '::apache::mod::php'
       $icinga_mysql_name = 'icinga'
       $icinga_mysql_user = 'icinga'
       $icinga_mysql_passwd = 'icinga'
       $icinga_mysql_host = 'localhost'
       $icinga_mysql_grant = 'ALL'
       $uninstall_package_name = 'Icinga Config'
       $uninstall_options = 'REMOVE'
       $uninstall_packages = 'icinga-config-gui'
       $package_icinga2_classicgui = 'icinga2-classicui-config'
       $package_icinga_gui = 'icinga-gui'
       $package_nagios_plugins = 'nagios-plugins-all'
       $usermod_icingauser = 'Adding_Icingacmd_User2Apache'
       $usermod_icingauser_command = '/usr/sbin/usermod -g icingacmd apache'
       $icinga_host_file = '/etc/icinga2/conf.d/hosts.conf'
       $icinga_host_file_source = 'puppet:///modules/crossover_icinga/hosts.conf'
       $icinga_command_file = '/etc/icinga2/conf.d/commands.conf'
       $icinga_command_file_source = 'puppet:///modules/crossover_icinga/commands.conf'
       $icinga_service_file = '/etc/icinga2/conf.d/services.conf'
       $icinga_service_file_source = 'puppet:///modules/crossover_icinga/services.conf'
       $restart_apache = '/usr/bin/systemctl restart httpd'
       $restart_icinga2 = '/usr/bin/systemctl restart icinga2'
       $disable_selinu = '/usr/sbin/setenforce 0'

   }

   'RedHat':  {
    
       $icinga_root_mysql_passwd = 'Tempor@l'
       $class_epel = '::epel'
       $class_icinga = '::icinga'
       $class_mysql_server =  '::mysql::server'
       $class_apache = 'apache'
       $class_apache_mod_php = '::apache::mod::php'
       $icinga_mysql_name = 'icinga'
       $icinga_mysql_user = 'icinga'
       $icinga_mysql_passwd = 'icinga'
       $icinga_mysql_host = 'localhost'
       $icinga_mysql_grant = 'ALL'
       $uninstall_package_name = 'Icinga Config'
       $uninstall_options = 'REMOVE'
       $uninstall_packages = 'icinga-config-gui'
       $package_icinga2_classicgui = 'icinga2-classicui-config'
       $package_icinga_gui = 'icinga-gui'
       $package_nagios_plugins = 'nagios-plugins-all'
       $usermod_icingauser = 'Adding_Icingacmd_User2Apache'
       $usermod_icingauser_command = '/usr/sbin/usermod -g icingacmd apache'
       $icinga_host_file = '/etc/icinga2/conf.d/hosts.conf'
       $icinga_host_file_source = 'puppet:///modules/crossover_icinga/hosts.conf'
       $icinga_command_file = '/etc/icinga2/conf.d/commands.conf'
       $icinga_command_file_source = 'puppet:///modules/crossover_icinga/commands.conf'
       $icinga_service_file = '/etc/icinga2/conf.d/services.conf'
       $icinga_service_file_source = 'puppet:///modules/crossover_icinga/services.conf'
       $restart_apache = '/usr/bin/systemctl restart httpd'
       $restart_icinga2 = '/usr/bin/systemctl restart icinga2'
       $disable_selinu = '/usr/sbin/setenforce 0'

}

default: {
  fail("saasops: module does not support Linux operatingsystem ${::operatingsystem}")
}
}
}
