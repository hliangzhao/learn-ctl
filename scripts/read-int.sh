#!/bin/zsh
# read-int: read from keyboard input
echo -n "Please enter an integer: "
read value
if [[ "$value" =~ ^-?[0-9]+$ ]]; then
	if (( $value == 0 )); then      # value and $value are both acceptable
		echo "$value is zero."
	else
		if (( value < 0 )); then
			echo "$value is neg."
		else
			echo "$value is pos."
		fi
		if (( (( $value % 2 )) == 0 )); then        # value and $value are both acceptable
			echo "$value is even."
		else 
			echo "$value is odd."
		fi
	fi
else
	echo "Input is not an integer." >&2
	exit 1
fi
