#!/bin/bash
#
# File: /<somedir>/getConnections.sh
# Purpose: May be run from crontab to use start and stop script to get current number of connections
#          for MWA by port. This can then be accessed from a web page to
#          ensure the load balancer will direct connections to the port
#          with the least number of connections
#
# Author: bthompso (Conundrum)
# Date: 3/17/2014
#
# Absolutely no warranty, use at your own risk
# Please include this header in any copy or reuse of the script you make
#
# Version 0.01
#
# Usage:
#       
#       
#       
#
#------------------------------------
#
# The following values must be changed for your environment
#

# directory where start stop scripts are located (please see https://github.com/Conundrum/Oracle/tree/master/MWA/Start_Stop)
MWA_HOME=/home/appltst
# set log type to 1 to log to a standard logging with logger (/var/log/messages), set to 0 to log to a file and set LOG_FILE for the file location
LOG_TYPE=1
# file to output results to that apache, or other web server will have access to
OUTPUT_FILE=/var/tmp/mwa_connections.txt
# set log file if LOG_TYPE is 0
LOG_FILE=/var/log/mwa_check.log
# set log tag if log type is set to 1
LOG_TAG=MWA


# check for permissions


check_permissions () {
  abort=0
  if [ ! -f $OUTPUT_FILE ]; then
    if [ $(touch $OUTPUT_FILE 2>&1 | grep "Permission Denied"  | wc -l) -ne 0 ]; then
      write_log "$OUTPUT_FILE is not writable by $(whoami)"
      echo ''
      echo "** $OUTPUT_FILE is not writeable by $(whoami) **"
      echo ''
      abort=1
    fi
  else
    if [ ! -w $OUTPUT_FILE ]; then
      write_log "$OUTPUT_FILE is not writable by $(whoami)"
      echo ''
      echo "** $OUTPUT_FILE is not writable by $(whoami) **"
      echo ''
      abort=1
    fi
  fi

  if [ $LOG_TYPE -eq 0 ]; then
    if [ ! -f $LOG_FILE ]; then
      if [ $(touch $LOG_FILE 2>&1 | grep "Permission Denied" | wc -l) -ne 0 ]; then
        echo ''
        echo "** $LOG_fILE is not writable by $(whoami) **"
        echo ''
        abort=1
      fi
    else
      if [ ! -w $LOG_FILE ]; then
        echo ''
        echo "** $LOG_FILE is not writable by $(whoami) **"
        echo ''
        abort=1
      fi
    fi
  fi


  if [ $abort -eq 1 ]; then
    echo 'Errors running script, please check log file, and run manually'
    exit 255
  fi
}

write_log () {
  if [ $LOG_TYPE -eq 1 ]; then
    logger -t $LOG_TAG "$1"
  else
    echo $1 > $LOG_FILE
  fi
}

write_file() {
  $MWA_HOME/mwa_ctrl.sh status | grep -v stopped | awk '{ print $2; print $8 }' > $OUTPUT_FILE
  write_log "MWA Connection Check Completed"
}


check_permissions
write_file
