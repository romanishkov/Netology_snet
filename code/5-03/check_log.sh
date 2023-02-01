badloadavg1=`tail -n 24 sys_state.log | awk 'BEGIN {fail_count=0} $8>=1 {fail_count++} END { print fail_count }'`
badmemfree=`tail -n 36 sys_state.log | awk 'BEGIN {fail_count=0} ($11*100/$12)>=60 {fail_count++} END { print fail_count }'`
baddiskfree=`tail -n 60 sys_state.log | awk 'BEGIN {fail_count=0} ($13*100/$14)>=60 {fail_count++} END { print fail_count }'`
return_code=0
if [[ $badloadavg1>=1 ]]; then 
	echo 'loadavg1 was bigger than 1 in last 2 minutes'
	((return_code++))
fi
if [[ $badmemfree>=1 ]]; then 
        echo 'memfree was bigger than 60% in last 3 minutes'
        ((return_code++))
fi
if [[ $baddiskfree>=1 ]]; then 
        echo 'diskfree was bigger than 60% in last 5 minutes'
        ((return_code++))
fi
exit $return_code
