#!/bin/bash
# without using words in for-loop, the for cmd will process positional params in default
for i; do
	if [[ -r $i ]]; then
		max_word=
		max_len=0
		for j in $(strings $i); do
			len=${#j}
			# len=$(echo $j | wc -c)
			if (( len > max_len )); then
				max_len=$len
				max_word=$j
			fi
		done
		echo "in $i: the longest word is '$max_word', with $max_len chars"
	fi
done
