#!/bin/bash
INTERFACE="$1"
ROOTUSER_NAME="root"

trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

#root check
username=$(id -nu)
if [ "$username" != "$ROOTUSER_NAME" ]
then
	echo "Must be root to run \"$(basename "$0")\"."
	exit 1
fi

if [[ -z "$INTERFACE" ]]; then
    echo "\$INTERFACE must be passed as argument"
    exit 1
fi

#find interface in 'ip a' output
ipa_int=$(ip a | grep -E "$INTERFACE(:|$)")
if [[ -z $ipa_int ]]; then
    echo "No such interface"
	exit 1
fi

#get IP/MASK from interface config
ipmask_text=$(echo "$ipa_int" | grep inet | awk ' { print $2 } ')

#make a list of all IP in subnet
IPLIST=$(nmap -sL -n "$ipmask_text" | awk '/Nmap scan report/{print $NF}')

for HOST in $IPLIST
do
	echo "[*] IP : ${HOST}"
	arping -c 3 -I "$INTERFACE" "${HOST}" 2> /dev/null
done
