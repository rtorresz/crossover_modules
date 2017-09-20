# Class: crossover_docker
#
# This module manages crossover_docker
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class crossover_docker (
	$docker_key = $crossover_docker::params::docker_key,
	$docker_id   = $crossover_docker::params::docker_id,
	$install_server   = $crossover_docker::params::install_server,
	$mysql_docker_image   = $crossover_docker::params::mysql_docker_image,
	$share_docker_directory = $crossover_docker::params::share_docker_directory,
	$share_docker2_directory = $crossover_docker::params::share_docker2_directory, 
	$name_mysql_container = $crossover_docker::params::name_mysql_container,
	$mysql_port_share = $crossover_docker::params::mysql_port_share,
	$mysql_root_passwd = $crossover_docker::params::mysql_root_passwd,
	$mysql_root_host = $crossover_docker::params::mysql_root_host,
	$mysql_share_volumes = $crossover_docker::params::mysql_share_volumes,
	$apache_docker_image = $crossover_docker::params::apache_docker_image,
	$name_apache_container = $crossover_docker::params::name_apache_container,
	$apache_port_share = $crossover_docker::params::apache_port_share,
	$apache_share_volumes = $crossover_docker::params::apache_share_volumes,
	$httpd_conf_file = $crossover_docker::params::httpd_conf_file,
	$source_httpd_conf = $crossover_docker::params::source_httpd_conf,
	$copy_httpdconf = $crossover_docker::params::copy_httpdconf,
	$command_copy_httpdconf = $crossover_docker::params::command_copy_httpdconf,
	$restart_httpdconf = $crossover_docker::params::restart_httpdconf,
	$command_restart_httpdconf = $crossover_docker::params::command_restart_httpdconf,
	$httpd_htaccess_file = $crossover_docker::params::httpd_htaccess_file,
	$source_htaccess_conf = $crossover_docker::params::source_htaccess_conf,
	$httpd_passwd_apache_file = $crossover_docker::params::httpd_passwd_apache_file,
	$source_passwd_apache_conf = $crossover_docker::params::source_passwd_apache_conf,
	$httpd_index_file = $crossover_docker::params::httpd_index_file,
	$source_index_conf = $crossover_docker::params::source_index_conf,
	$script_backupslogs_file = $crossover_docker::params::script_backupslogs_file,
	$source_backupslogs_file = $crossover_docker::params::source_backupslogs_file,
	$name_script_logs = $crossover_docker::params::name_script_logs,
	$command_script_logs = $crossover_docker::params::command_script_logs,
	$mysql_permission = $crossover_docker::params::mysql_permission,
	$command_mysql_permission = $crossover_docker::params::command_mysql_permission,
	$rsyslog_docker_image = $crossover_docker::params::rsyslog_docker_image,
	$name_rsyslog_container = $crossover_docker::params::name_rsyslog_container,
	$rsyslog_port_share = $crossover_docker::params::rsyslog_port_share,
	$rsyslog_share_volumes = $crossover_docker::params::rsyslog_share_volumes,
	$mysql_extra_parameters = $crossover_docker::params::mysql_extra_parameters,
	$apache_extra_parameters = $crossover_docker::params::apache_extra_parameters,


	) inherits crossover_docker::params{



######### Instalando Docker only for ubuntu

#  apt::key { $docker_key:
#    id      => $docker_id,
##    server  => $install_server,
#  }

include 'docker'

######### Image for Rsyslog (Centralized logging) from hub.docker

docker::image { $rsyslog_docker_image: }

######## Run container with Apache
docker::run { $name_rsyslog_container:
	image   => $rsyslog_docker_image,
 	ports   => $rsyslog_port_share,
 	volumes => $rsyslog_share_volumes,

 }

######### Image for MySQL from hub.docker
docker::image { $mysql_docker_image: }

# docker pull name_docker_image

######## Creating share folder in docker server /opt/share_mysql

file { $share_docker_directory:
ensure => 'directory',
	owner  => 'root',
	group  => 'root',
	mode   => '0755',
}

file { $share_docker2_directory:
ensure => 'directory',
	owner  => 'root',
	group  => 'root',
	mode   => '0755',
}
#docker run --name my-container-name -p 3306:3306 -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql/mysql-server:tag

######## Run container with MySQL
docker::run { $name_mysql_container:
	image   => $mysql_docker_image,
	ports   => $mysql_port_share,
	env     => $mysql_root_passwd,
    #env     => $mysql_root_host,
    volumes => $mysql_share_volumes,
    extra_parameters => [$mysql_extra_parameters],
    #extra_parameters => [ '--log-driver=syslog --log-opt syslog-address=udp://127.0.0.1:5514 --log-opt syslog-facility=daemon --log-opt tag=MysqlCrossover' ],

}

  ##### Docker Exec for MySQL permissions
  #docker::exec { $mysql_permission:
  #  detach    => true,
  #  interactive => true,
  #  tty       => true,
  #  container => $name_mysql_container,
  #  command      => $command_mysql_permission,
  #}

 ######### Image for Apache from hub.docker
 docker::image { $apache_docker_image: }

 ######## Run container with Apache
 docker::run { $name_apache_container:
 	image   => $apache_docker_image,
 	ports   => $apache_port_share,
 	volumes => $apache_share_volumes,
 	extra_parameters => [$apache_extra_parameters],
 	#extra_parameters => [ '--log-driver=syslog --log-opt syslog-address=udp://127.0.0.1:5514 --log-opt syslog-facility=daemon --log-opt tag=ApacheCrossover' ],

 }

  ##### Copy http.conf to $share_docker_directory

  file {
  	$httpd_conf_file:
  ensure => file,
  	source => $source_httpd_conf,
  }

  ##### Copy .htaccess to $share_docker_directory

  file {
  	$httpd_htaccess_file:
  ensure => file,
  	mode   => '0644',
  	source => $source_htaccess_conf,
  }

  ##### Copy passwd.apache to $share_docker_directory

  file {
  	$httpd_passwd_apache_file:
  ensure => file,
  	source => $source_passwd_apache_conf,
  }

##### Copy index.html to $share_docker_directory

file {
	$httpd_index_file:
ensure => file,
 #   owner  => 'www-data',
 #   group  => 'www-data',
 #   mode   => '0755',
 source => $source_index_conf,
}

##### Docker Exec for httpd.conf
docker::exec { $copy_httpdconf:
	detach    => true,
	interactive => true,
	tty       => true,
	container => $name_apache_container,
	command      => $command_copy_httpdconf,
}

docker::exec { $restart_httpdconf:
	detach    => true,
	interactive => true,
	tty       => true,
	container => $name_apache_container,
	command      => $command_restart_httpdconf,
}

############ Copy script for log backup to server-docker

file {
	$script_backupslogs_file:
ensure => file,
	source => $source_backupslogs_file,
}

##### Configurar cron.daily

cron::job { $name_script_logs:
	minute      => '00',
	hour        => '19',
	date        => '*',
	month       => '*',
	weekday     => '*',
	user        => 'root',
	command     => $command_script_logs,
	environment => [ 'MAILTO=root', 'PATH="/usr/bin:/bin"', ],
	description => 'Logs Backups and copy to S3 bucket',
}


}# End class crossover_docker
