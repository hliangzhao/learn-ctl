#!/bin/bash
# validate input

invalid_input() {
	echo "Invalid input '$REPLY'!" >&2
	exit 1
}

read -p "Enter a single item: "        # if no var is defined, the input will be stored in $REPLY

# if input is empty
[[ -z $REPLY ]] && invalid_input

# if input are multi items
(( $(echo $REPLY | wc -w) > 1 )) && invalid_input

# if input is a valid filename
if [[ $REPLY =~ ^[-[:alnum:]\._]+$ ]]; then
	echo "'$REPLY' is a valid filename (or dir)!"
	if [[ -e $REPLY ]]; then
		echo "'$REPLY' exists!"
	else
		echo "However, '$REPLY' not exists!"
	fi
	# if input is a floating number
	if [[ $REPLY =~ ^-?[[:digit:]]*\.[[:digit:]]+$ ]]; then
		echo "'$REPLY' is a floating number!"
	else
		echo "'$REPLY' is not a floating number!"
	fi
	# if input is an integer
	if [[ $REPLY =~ ^-?[[:digit:]]+$ ]]; then
		echo "'$REPLY' is an integer!"
	else
		echo "'$REPLY' is not an integer!"
	fi
else
	echo "'$REPLY' is not a valid filename (or dir)!"
fi
