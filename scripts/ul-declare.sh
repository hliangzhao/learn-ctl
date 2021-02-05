#!/bin/bash
# use declare to normalize strings to uppercase or lowercase
declare -u upper   # (-u and -l are not supperted on macOS since the version of bash in default in macOS is 3.2)
declare -l lower

if [[ $1 ]]; then
	upper="$1"
	lowe="$1"
	echo $upper"\t"$lower
fi
