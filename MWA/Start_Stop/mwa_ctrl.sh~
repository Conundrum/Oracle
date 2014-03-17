#!/bin/bash

#######################################################
#####      DEV MWA START / STOP SCRIPT            #####
#######################################################
#####         modified by: bthompso               #####
#####         modified date: 11/19/2013           #####
#######################################################
#######################################################

source ~/mwa_ctrl.conf

if [ -n "$2" ]; then
  ports="$2"
fi


# start function
start() {
	for i in $ports
	do
	  pid=`ps -ef | grep mwa | grep $i | grep -v mwa_ctrl.sh | awk {' print $2 '}`
          if [ $pid > 0 ]; then
            echo "Warning mwa server on port $i is already running -- please stop first"
     	  else
	    $MWACTL start $i &
          fi
	done



}



# stop function
stop() {
	for i in $ports
	do
	  $MWACTL -login $sysad_user/$sysad_pwd stop_force $i
	  sleep 10
	  pid=`ps -ef | grep mwa | grep $i | grep -v mwa_ctrl.sh | awk {' print $2 '}`
 	  ps -ef | grep mwa | grep $i 
	  if [ $pid > 0 ]; then
	    echo "Warning mwa server on port $i failed to stop, sending signal 15 to kill process, please recheck"
	    kill -15 $pid
          fi

	done
}

restart() {
	stop
	start
}

status() {
	for i in $ports
	do
	  pid=`ps -ef | grep mwa | grep $i | grep -v mwa_ctrl.sh | awk {' print $2 '}`
	  users=`netstat -an | grep 10.80.1.17 | grep $i | wc -l`
	  if [ $pid > 0 ]; then
  	    echo -e "server $i is running \t  pid: \t $pid \t  users: \t $users";
	  else
 	    echo "WARNING server $i is stopped";
	  fi
	done
}



### main logic ###

case "$1" in
   start)
	start
	;;
   stop)
	stop
	;;
   restart)
	start
	stop
	;;
   status)
	status
	;;

   *)
	echo $"Usage: $0 {start|stop|status|restart}"
esac
exit 0



#. /home/appldev/start_stop.env
#sh /DEV/oracle/devappl/mwa/11.5.0/bin/mwactl.sh start 2323 &
#cd /DEV/oracle/devappl/mwa/11.5.0/bin/
#sh mwactl.sh start_dispatcher &

