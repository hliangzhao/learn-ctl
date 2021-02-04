#!/bin/bash
# use case to develop a menu-driven program
clear
echo "Please select:
	1. Display System Information
	2. Display Disk Space
	3. Display Home Space Utilization
	0. Quit"

read -p "Enter selection [0-3]: "
case $REPLY in
	0)	echo "Program terminated."
		exit
		;;
	1)	echo "Hostname: $HOSTNAME"
		uptime
		;;
	2) 	df -h
		;;
	3)	if [[ $(id -u) -eq 0 ]]; then
			echo "Home space utilization (all users)"
			du -sh /Users/*
		else
			echo "Home space utilization (for $USER)"
			du -sh /Users/$USER/*
		fi
		;;
	*) echo "Invalid entry" >&2
		exit 1
		;;
esac
