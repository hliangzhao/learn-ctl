#!/bin/bash
# use modulo operator to find the number who can be devided by 5 exactly
for (( i=0; i<=20; i++ )); do
	remainder=$((i%5))
	if (( remainder==0 )); then
		printf "<%d> " $i
	else
		printf "%d " $i
	fi
done
echo "\n"
