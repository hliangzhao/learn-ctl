#!/bin/bash
# test-integer: evalue the value of an integer.
INT_VAR=-5
if [ -z "$INT_VAR" ]; then
	echo "INT is empty." >&2
	exit 1
fi
if [ "$INT_VAR" -lt "0" ]; then
	echo "INT is neg."
else
	echo "INT is pos."
fi
if [ $((INT_VAR % 2)) -eq 0 ]; then
	echo "INT is even."
else
	echo "INT is odd."
fi

# use [[ ]] to perform "str =~ regex"
INT_VAR2=10x
if [[ "$INT_VAR2" =~ '^-?[0-9]+$' ]]; then  # for the regexi ^-?[0-9]+$, '' and "" are not required
	echo "$INT_VAR2 is an integer."
else
	echo "$INT_VAR2 is not an integer."
fi

# use [[ ]] to perform "==" (with pathname expansion)
FILE=~/.zshrc
if [[ $FILE == ~/.zsh* ]]; then
	echo "$FILE matches the pattern ~/.zsh*"
fi
