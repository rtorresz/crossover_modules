#!/bin/sh
#
#       Creating scripts for get logs of Docker Servers
#       Crossover  Rafael Torres
#       September 2017
#
#       


### Variables
fecha=`date +%Y-%m-%d`
apache_logs_docker="/usr/local/apache2/logs/access_log"
apache_dest_docker="/usr/local/apache2/htdocs"
mysql_logs_docker="/var/log/mysqld.log"
logs_dir_sdocker="/var/www/html"
logs_dir_mysql="/opt/share_mysql/"
backups_logs="backups_logs"
name_apache_container="Apache-server-temporal"
name_db_container="MySQl-server-temporal"
bucket_name="crossoverbucketlog"


### Creating folder for Logs Backups

echo "Creating folder for backups in $logs_dir_sdocker/$backups_logs/$fecha"

if [ -d $logs_dir_sdocker/$backups_logs/$fecha ];then
	
	echo "There is a folder ... creating subfolder"

	else

	mkdir -p $logs_dir_sdocker/$backups_logs/$fecha
fi

### Copy logs Apache docker to docker server folder
docker exec -it $name_apache_container bash -c "cp -r $apache_logs_docker $apache_dest_docker/$backups_logs/$fecha"

### Copy logs Mysql docker to docker server folder ### OJO SE DEBE CREAR ENLACE SIMBOLICO PARA /VAR/WWW/HTML
docker exec -it $name_db_container bash -c "cp -r $mysql_logs_docker $logs_dir_mysql/$backups_logs/$fecha"


### Copy to s3 from

aws s3 sync /var/www/html/backups_logs s3://$bucket_name/$backups_logs

### Copy to s3 from Rsyslog
aws s3 sync /var/log/rsyslog s3://$bucket_name/$backups_logs/$fecha


exit 0