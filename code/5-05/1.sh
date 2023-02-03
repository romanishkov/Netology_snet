#!/bin/bash
PREFIX="${1:-NOT_SET}"
INTERFACE="$2"
SUBNET="$3"
HOST="$4"
ROOTUSER_NAME="root"

trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

#root check
username=`id -nu`
if [ "$username" != "$ROOTUSER_NAME" ]
then
	echo "Must be root to run \"`basename $0`\"."
	exit 1
fi

[[ "$PREFIX" = "NOT_SET" ]] && { echo "\$PREFIX must be passed as first positional argument"; exit 1; }
if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as second positional argument"
    exit 1
fi

#INPUT IP regexp check
if ! [[ "$PREFIX" =~ ^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]?[0-9])\.(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]?[0-9])$ ]]; then
	echo "$PREFIX is not a valid prefix"
	exit 1
fi
if [[ ! ( -z "$SUBNET" )]] && [[ ! ("$SUBNET" =~ ^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]?[0-9])$) ]]; then
    echo "$SUBNET is not a valid subnet"
    exit 1
fi
if [[ ! ( -z "$HOST" )]] && [[ ! ("$HOST" =~ ^(25[0-5]|2[0-4][0-9]|[0-1]?[0-9]?[0-9])$) ]]; then
	echo "$HOST is not a valid host"
    exit 1
fi

if [[ -z "$SUBNET" ]]; then
	for SUBNET in {1..255}
	do
		if [[ -z "$HOST" ]]; then
			for HOST in {1..255}
			do
				echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
				arping -c 3 -I "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
			done
		else
			echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
            arping -c 3 -I "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
		fi
	done
else
	if [[ -z "$HOST" ]]; then
        	for HOST in {1..255}
                do
                	echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
                    arping -c 3 -I "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
                done
        else
                echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
                arping -c 3 -I "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
	fi
fi
