#!/bin/bash
# use while-loop to read from pipe
sort -k 1,1 -k 2n distros.txt | while read distro version release; do
	printf "Distribution: %s\tVersion: %s\tReleased: %s\n" \
		$distro $version $release
done
