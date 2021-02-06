#!/bin/bash
# use trap to handle signals
trap "echo 'I am ignoreing you'" SIGINT SIGTERM
for i in {1..5}; do
	echo "Iteration $i of 5"
	sleep 5
done
