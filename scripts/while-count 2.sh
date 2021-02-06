#!/bin/bash
# use while to display a series numbers
count=1
while (( count <= 5 )); do
	echo $count
	count=$((count + 1))
done
echo "Finished."
