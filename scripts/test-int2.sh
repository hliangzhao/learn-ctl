#!/bin/zsh
# test-int2: evaluate integer with (())
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
	if (( INT == 0 )); then      # note we do not use $INT to do expansion becasue (()) is shell builtins, it can identify the variables with their name directly
		echo "INT is zero."
	else
		if (( INT < 0 )); then
			echo "INT is neg."
		else 
			echo "INT is pos."
		fi
		if (( ((INT % 2)) == 0 )); then
			echo "INT is even."
		else
			echo "INT is odd."
		fi
	fi
else
	echo "INT is not an integer." >&2
	exit 1
fi
