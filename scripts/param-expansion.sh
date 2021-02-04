#!/bin/bash
# use $* and $@ to expand positional parameters

print_params() {
	echo -e "\$1: $1\n\$2: $2\n\$3: $3\n\$4: $4"
}

pass_params() {
	echo -e '\nexpand $*: ';		print_params $*
	echo -e '\nexpand "$*": ';		print_params "$*"
	echo -e "\nexpand '\$*': "; 	print_params '$*'    # no expansion happend, $* is treated as simple chars without meanings
	
	echo -e '\n\nexpand $@: ';		print_params $@
	echo -e '\nexpand "$@": ';		print_params "$@"
	echo -e "\nexpand '\$@': ";		print_params '$@'
}

pass_params "word" "words with spaces"
