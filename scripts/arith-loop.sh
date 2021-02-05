#!/bin/bash
# use arithmetic operators
end=0
a=0
printf "a\ta**2\ta**3\n"
printf "=\t====\t====\n"
until (( end )); do
	b=$(( a**2 ))
	c=$(( a**3 ))
	printf "%d\t%d\t%d\n" $a $b $c
	(( a < 10? ++a: ( end=1 ) ))
done
