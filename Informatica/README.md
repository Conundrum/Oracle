# INFORMATICA
## init.d startup/shutdown script
### installation
	1: copy informatica file to /etc/init.d
	2: chmod 750 /etc/init.d/informatica
	3: chkconfig --add informatica
	4: modify /etc/init.d/informatica to set the INFO_SERVICE variable, this should be your informatica bin directory 
	   with no trailing slash
