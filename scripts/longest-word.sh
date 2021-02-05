#!/bin/bash
# find the longest string in a file by using for-loop
while [[ -n $1 ]]; do
	if [[ -r $1 ]]; then
		max_word=
		max_len=0
		for i in $(strings $1); do
			len=$(echo $i | wc -c)
			if (( len > max_len )); then
				max_len=$len
				max_word=$i
			fi
		done
		echo "in $1: the longest word is '$max_word' ('$max_len' chars)"
	fi
	shift
done
