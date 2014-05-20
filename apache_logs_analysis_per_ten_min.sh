#!/bin/bash
##################################
# Usage:
#   ./apache_logs_analysis_per_ten_min.sh http_access.log '16/May/2014:12' 
##################################
LOG=$1
TIMERANGE=$2

function analysis() {
 LOG=$1
 TIME=$2
 echo -n "Total requests number matching $TIME : "
 grep -c $TIME $LOG
 echo -n "Total 200 requests: "
 grep $TIME $LOG | grep 'HTTP/1.1" 200 ' -c
 echo -n "Total 302 requests: "
 grep $TIME $LOG | grep 'HTTP/1.1" 302 ' -c
 echo -n "Total 304 requests: "
 grep $TIME $LOG | grep 'HTTP/1.1" 304 ' -c
 echo -n "Total 500 requests: "
 grep $TIME $LOG | grep 'HTTP/1.1" 500 ' -c  
}


analysis $LOG $TIMERANGE

for a in $( seq -s ' ' 0 1 5); do
 analysis $LOG $TIMERANGE:$a
done  


# EOF
