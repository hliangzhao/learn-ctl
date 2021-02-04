#!/bin/bash
# use shift to process all cmd params
count=1
while (( $# > 0 )); do
	echo "Arg $count = $1"
	count=$((count+1))
	shift
done
