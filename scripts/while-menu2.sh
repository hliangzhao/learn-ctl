#!/bin/bash
# use while to produce a menu driven system program

DELAY=3
while true; do
	clear
	cat <<- _EOF_
	Please Select:
	1. Display System Information
	2. Display Disk Space
	3. Display Home Space Utilization
	0. Quit
	_EOF_

	read -p "Enter selection [0-3]: "
	if [[ $REPLY =~ ^[0-3]$ ]]; then
		if [[ $REPLY == 1 ]]; then
			echo "Hostname: $HOSTNAME"
			uptime
			sleep $DELAY
		elif  [[ $REPLY == 2 ]]; then
			df -h
			sleep $DELAY
		elif [[ $REPLY == 3 ]]; then
			if [[ $(id -u) -eq 0 ]]; then
				echo "Home Space Utilization (All Users)"
				du -sh /Users/*
			else
				echo "Home Space Utilization (for $USER)"
				du -sh /Users/$USER/*
			fi
			sleep $DELAY
		elif [[ $REPLY == 0 ]]; then
			break
		fi
	else
		echo "Invalid entry."
		sleep $((DELAY - 2))
	fi
done
echo "Program terminated."
