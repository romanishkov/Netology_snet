avgfile(){
	folder=$1
	size_sum=0
	counter=0
	if [[ -d $folder ]]; then
		cd $folder
		for item in *; do
			if [[ -f $item ]]; then
				(( size_sum+=`stat -c "%s" $item` ))
				(( counter++ ))
			fi;
		done;
		echo "Average file size is $(( $size_sum/$counter ))"
	else
		echo "$folder is not a directory"
	fi;
}
avgfile $1