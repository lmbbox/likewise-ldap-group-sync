#!/bin/bash


echo "LDAP Group Membership Sync Script"


# Check that this distribution is Ubuntu
if grep -qvi ubuntu <<< `uname -v`
then
	echo "This script is meant for Ubuntu distributions only."
	exit 1
fi


# Check if root
if [ $UID != 0 ]
then
	echo "You are not root. This script must be run with root permissions."
	exit 1
fi


# Filepath
root=$(dirname $(readlink -f $0))


# Read config file and assign values
for file in $root/group.d/*
do
	source $file
	echo $file
	echo $ADGROUP
	echo $LOCALGROUP
	echo $DEFAULTUSERS
	
	USERS=`lw-enum-members $ADGROUP | awk -vORS=',' '/SAM account name:/ {print $4}' | sed '$s/.$//'`
	
	if [ -n $DEFAULTUSERS ]
	then
		if [ -n $USERS ]
		then
			USERS="$DEFAULTUSERS,$USERS"
		else
			USERS="$DEFAULTUSERS"
		fi
	fi
	
	echo $USERS
	
	sudo sed -i 's/^\('$LOCALGROUP':[^:]*:[0-9][0-9]*:\).*$/\1'$USERS'/' /etc/group
done

echo
echo "LDAP Group Membership Sync Complete."
