#!/bin/zsh
# use logical operators

MIN_VAL=1
MAX_VAL=100
INT=50

if [[ "$INT" =~ ^-?[0-9]+$  ]]; then
	if [[ INT -ge MIN_VAL && $INT -le MAX_VAL ]]; then    # both INT and $INT are acceptable
		echo "$INT is within $MIN_VAL and $MAX_VAL"
	fi
fi

if [[ "$INT" =~ ^-?[0-9]+$  ]]; then
   if [ \( $INT -ge $MIN_VAL -a $INT -le $MAX_VAL \) ]; then
        echo "$INT is within $MIN_VAL and $MAX_VAL"
    fi
fi
