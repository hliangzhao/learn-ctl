#!/bin/bash
#  read-secret: input a secret pass phrase
if read -t 10 -s -p "Enter secret pass phrase > " secret_pass; then
    echo ""
	echo "Secret pass phrase = '$secret_pass'"
else
    echo ""
	echo "Input timed out" >&2
    exit 1
fi
