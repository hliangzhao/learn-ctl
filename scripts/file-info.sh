#!/bin/bash
PROG_NAME=$(basename $0)
if [[ -e $1 ]]; then
	echo -e "\nFile Type:"
	file $1
	echo -e "\nFile Status:"
	stat $1
else
	echo "$PROG_NAME: usage: $PROG_NAME file" >&2
	exit 1
fi
