class crossover_docker::params {

  case $::osfamily {
    'Debian':  {
    $docker_key = 'docker'
    $docker_id = '58118E89F3A912897C070ADBF76221572C52609D'
    $install_server = 'p80.pool.sks-keyservers.net'
    $mysql_docker_image = 'mysql/mysql-server'
    $share_docker_directory = '/var/www'
    $share_docker2_directory = '/var/www/html'
    $name_mysql_container = 'MySQl-server-temporal'
    $mysql_port_share = '3306:3306'
    $mysql_root_passwd = 'MYSQL_ROOT_PASSWORD=temporal -e MYSQL_ROOT_HOST=172.17.0.1'
    $mysql_share_volumes = '/var/www/html:/opt/share_mysql'
    $apache_docker_image = 'httpd'
    $name_apache_container = 'Apache-server-temporal'
    $apache_port_share = '80:80'
    $apache_share_volumes = '/var/www/html:/usr/local/apache2/htdocs/'
    $httpd_conf_file = '/var/www/html/httpd.conf'
    $source_httpd_conf = 'puppet:///modules/crossover_docker/httpd.conf'
    $copy_httpdconf = 'copy_httpdconf'
    $command_copy_httpdconf = '/bin/cp -r /usr/local/apache2/htdocs/httpd.conf /usr/local/apache2/conf/httpd.conf'
    $restart_httpdconf = 'restart_httpdconf'
    $command_restart_httpdconf = 'httpd -k restart'
    $httpd_htaccess_file = '/var/www/html/.htaccess'
    $source_htaccess_conf = 'puppet:///modules/crossover_docker/.htaccess'
    $httpd_passwd_apache_file = '/var/www/html/passwd.apache'
    $source_passwd_apache_conf = 'puppet:///modules/crossover_docker/passwd.apache'
    $httpd_index_file = '/var/www/html/index.html'
    $source_index_conf = 'puppet:///modules/crossover_docker/index.html'
    $script_backupslogs_file = '/var/www/html/get_logs_docker.sh'
    $source_backupslogs_file = 'puppet:///modules/crossover_docker/get_logs_docker.sh'
    $name_script_logs = 'logsbackup-s3'
    $command_script_logs = '/bin/sh /var/www/html/get_logs_docker.sh'
    $mysql_permission = 'mysql_permission'
    $command_script_logs = '/bin/sh /var/www/html/get_logs_docker.sh'
    ## Rsyslog
    $rsyslog_docker_image = 'voxxit/rsyslog'
    $name_rsyslog_container = 'rsyslog-crossover'
    $rsyslog_port_share = '127.0.0.1:5514:514/udp'
    $rsyslog_share_volumes = '/var/log/rsyslog:/var/log'
    $mysql_extra_parameters = '--log-driver=syslog --log-opt syslog-address=udp://127.0.0.1:5514 --log-opt syslog-facility=daemon --log-opt tag=MysqlCrossover'
    $apache_extra_parameters = '--log-driver=syslog --log-opt syslog-address=udp://127.0.0.1:5514 --log-opt syslog-facility=daemon --log-opt tag=ApacheCrossover'

    }
    
    'RedHat':  {
   $docker_key = 'docker'
    $docker_id = '58118E89F3A912897C070ADBF76221572C52609D'
    $install_server = 'p80.pool.sks-keyservers.net'
    $mysql_docker_image = 'mysql/mysql-server'
    $share_docker_directory = '/var/www'
    $share_docker2_directory = '/var/www/html'
    $name_mysql_container = 'MySQl-server-temporal'
    $mysql_port_share = '3306:3306'
    $mysql_root_passwd = 'MYSQL_ROOT_PASSWORD=temporal -e MYSQL_ROOT_HOST=172.17.0.1'
    $mysql_share_volumes = '/var/www/html:/opt/share_mysql'
    $apache_docker_image = 'httpd'
    $name_apache_container = 'Apache-server-temporal'
    $apache_port_share = '80:80'
    $apache_share_volumes = '/var/www/html:/usr/local/apache2/htdocs/'
    $httpd_conf_file = '/var/www/html/httpd.conf'
    $source_httpd_conf = 'puppet:///modules/crossover_docker/httpd.conf'
    $copy_httpdconf = 'copy_httpdconf'
    $command_copy_httpdconf = '/bin/cp -r /usr/local/apache2/htdocs/httpd.conf /usr/local/apache2/conf/httpd.conf'
    $restart_httpdconf = 'restart_httpdconf'
    $command_restart_httpdconf = 'httpd -k restart'
    $httpd_htaccess_file = '/var/www/html/.htaccess'
    $source_htaccess_conf = 'puppet:///modules/crossover_docker/.htaccess'
    $httpd_passwd_apache_file = '/var/www/html/passwd.apache'
    $source_passwd_apache_conf = 'puppet:///modules/crossover_docker/passwd.apache'
    $httpd_index_file = '/var/www/html/index.html'
    $source_index_conf = 'puppet:///modules/crossover_docker/index.html'
    $script_backupslogs_file = '/var/www/html/get_logs_docker.sh'
    $source_backupslogs_file = 'puppet:///modules/crossover_docker/get_logs_docker.sh'
    $name_script_logs = 'logsbackup-s3'
    $command_script_logs = '/bin/sh /var/www/html/get_logs_docker.sh'
    $mysql_permission = 'mysql_permission'
    $command_mysql_permission = '/bin/cp -r /usr/local/apache2/htdocs/httpd.conf /usr/local/apache2/conf/httpd.conf'
    ## Rsyslog
    $rsyslog_docker_image = 'voxxit/rsyslog'
    $name_rsyslog_container = 'rsyslog-crossover'
    $rsyslog_port_share = '127.0.0.1:5514:514/udp'
    $rsyslog_share_volumes = '/var/log/rsyslog:/var/log'
    $mysql_extra_parameters = '--log-driver=syslog --log-opt syslog-address=udp://127.0.0.1:5514 --log-opt syslog-facility=daemon --log-opt tag=MysqlCrossover'
    $apache_extra_parameters = '--log-driver=syslog --log-opt syslog-address=udp://127.0.0.1:5514 --log-opt syslog-facility=daemon --log-opt tag=ApacheCrossover'

    }

    default: {
          fail("saasops: module does not support Linux operatingsystem ${::operatingsystem}")
        }
  }
}
