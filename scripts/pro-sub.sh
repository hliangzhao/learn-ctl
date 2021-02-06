#!/bin/bash
# use process substituion
while read attr links owner group size month day time filename; do
	cat <<- EOF
		Filename:	$filename
		Size: 		$size
		Owner:		$owner
		Group: 		$group
		Modified:	$month $day $time
		Links: 		$links
		Attributes: $attr
	EOF
done < <(ls -l | tail -n +2)   # tail is used toi remove the first line of 'ls -l'
