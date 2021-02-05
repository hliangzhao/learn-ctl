#!/bin/bash
PROGNAME=$(basename $0)
usage() {
	echo "$PROGNAME: usage: $PROGNAME [-t principal interest months | -i]"
	return
}

interactive=
principal=
interest=
months=

if [[ -n $1 ]]; then
	case $1 in 
	-t)	
		principal=$2
		interest=$3
		months=$4
		;;
	-i)	
		interactive=1
		;;
	-h | --help)
		usage >&2
		exit 1
		;;
	esac
fi

if [[ -n $interactive ]]; then
	read -p "Enter the amount of the loan: " principal
	read -p "Enter the interest of the loan: " interest
	read -p "Enter the length of the loan's term: " months
fi

bc <<- _EOF_
	scale=10
	i=$interest/12
	p=$principal
	n=$months
	a=p*((i*((i+1)^n))/(((i+1)^n)-1))
	print a, "\n"
_EOF_
