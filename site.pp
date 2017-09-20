notice( "Processing catalog from the Test environment." )

node default { }

node 'docker-server-ubuntu.saasops.com' {

include crossover_docker

} # End Host


node 'icinga-server-centos6.saasops.com' {

include crossover_icinga

} # End Host
