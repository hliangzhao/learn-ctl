#!/bin/bash
# use util to count numbers

count=5
until (( count == 0 )); do
	echo $count
	count=$((count - 1))
done
echo "Finished."
