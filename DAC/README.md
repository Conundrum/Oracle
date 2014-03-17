#Oracle Data Warehouse Administration Console (DAC)
##init.d startup/shutdown script
### installation
	1: copy dac file to /etc/init.d
	2: chmod 750 /etc/init.d/dac
	3: chkconfig --add dac
	4: modify /etc/init.d/dac to set DAC_HOME this should be the dac directory (eg. /oracle/dac) with no trailing slash


	
