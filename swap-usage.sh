#!/bin/bash
# Get current swap usage for all running processes
# Lukasz Mazurek 25-06-2015
SUM=0
OVERALL=0
for DIR in `find /proc/ -maxdepth 1 -type d | egrep "^/proc/[0-9]"` ; do
PID=`echo $DIR | cut -d / -f 3`
PROGNAME=`ps -p $PID -o comm --no-headers`
for SWAP in `grep VmSwap $DIR/status 2>/dev/null|awk '{print $2}'`
do
let SUM=$SUM+$SWAP
done
echo "PID=$PID - Swap used: $SUM kB - ( $PROGNAME )"
let OVERALL=$OVERALL+$SUM
SUM=0

done
echo "Overall swap used: $OVERALL kB"
