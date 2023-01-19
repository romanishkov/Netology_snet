read a
read b
if [ $a -gt $b ]; then
	echo $((a-b))
elif [ $a -lt $b ]; then
	echo $((b-a))
else
	echo $((a*b))
fi;
