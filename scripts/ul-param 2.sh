#!/bin/bash
# use param expansion to demonstrate case conversion
if [[ $1 ]]; then
	# the following are not supported by bash 3.2, the default version in macOS
	echo ${1,,}
	echo ${1,}
	echo ${1^^}
	echo ${1^}
fi
