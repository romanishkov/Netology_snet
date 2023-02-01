while true; do
	timestamp=`date`
	loadavg=`cat /proc/loadavg | awk ' { print $1 " " $2 " " $3 } '`
	ram=`free | awk ' NR==2 { print $4 " " $2 } '`
	disk=`df | awk ' $6=="/" { print $4 " " $2 } '`
	echo $timestamp $loadavg $ram $disk >> sys_state.log
	sleep 5
done
