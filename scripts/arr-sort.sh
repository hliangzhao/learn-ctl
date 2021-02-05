#!/bin/bash
# sort a array
a=(f e d a c b)
echo "Original: ${a[@]}"     # use ${arr_name[@]} to access every element in the array
a_sorted=($( for i in "${a[@]}"; do echo $i; done | sort ))
echo "Sorted: ${a_sorted[@]}"
