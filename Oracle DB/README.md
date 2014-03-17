#ORACLE DB SCRIPTS
##init.d instructions
	1: copy init.d/oracle script to /etc/init.d
	2: chmod 750 /etc/init.d
	3: chkconfig --add oracle
	4: copy scripts/dbshut and scripts/dbstart to $ORACLE_HOME/bin
	5: modify oracle script and set ORACLE_HOME and ORACLE_USER
	6: modify dbshut and dbstart scripts to set LISTNER_NAME


