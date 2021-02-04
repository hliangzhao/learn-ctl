#!/bin/bash
# read fileds from a file, and set the separator as ':'
FILE=/etc/passwd
read -p "Enter a user name: " user_name
file_info=$(grep "^$user_name:" $FILE)

if [ -n "$file_info" ]; then
	OLD_IFS="$IFS"
	IFS=":"
	read user pw uid gid name home shell <<< "$file_info"
	echo "User: '$user'"
	echo " UID: '$uid'"
	echo " GID: '$gid'"
	echo "Full Name: '$name'"
	echo "Home Dir: '$home'"
	echo "Shell: '$shell'"
else
	echo "No such user $user_name"
	exit 1
fi
