#!/bin/bash
select oper in '+' '-' '*' '/'; do
	echo 'Enter the first number:'
	while true; do
        read a
		expr $a + 1 2> /dev/null
		if [ $? = 0 ]; then
			break
        else
            echo 'Please enter only numbers. Try again:'
        fi
    done
	echo 'Enter the second number:'
	while true; do
        read b
		expr $a + 1 2> /dev/null
            if [[ $? = 0 ]]; then
                break
            else
				echo 'Please enter only numbers. Try again:'
            fi
        done
	case $oper in
	'+')
		echo "$a+$b=$((a+b))"; break;;
	'-')
		echo "$a-$b=$((a-b))"; break;;
	'*')
		echo "$a*$b=$((a*b))"; break;;
	'/')
		if [[ $b != 0 ]]; then echo "$a/$b=$((a/b))";
		else echo "You can't divide by zero";
		fi;
		break;;
	esac
done
