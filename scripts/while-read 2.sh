#!/bin/bash
# read lines from a file by using while-loop
OLD_IFS="$IFS"
IFS=":"

while read user pw uid gid name home shell; do
	printf "User: %s\nUID: %s\nGID: %s\nHome: %s\n\n" \
		$user $uid $gid $home
done < root-file

IFS="$OLD_IFS"
