#!/bin/bash
freeMem=$(free | awk '{if(NR == 2) print $4}')
cpuUsage=$(top -bn2 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{if(NR == 2) print 100 - $1}')
	if [ $( echo "$freeMem > 300000" | bc -l ) ] && [ $( echo "$cpuUsage < 45" | bc -l ) ];
then	
	/etc/osync/syncWithLock.sh >> /dev/null 2>&1
else
	echo "0"
fi
