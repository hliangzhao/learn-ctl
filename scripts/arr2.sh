#!/bin/zsh
# use group cmds and subshells
declare -A files file_group file_owner groups owners  # -A is used to create "related arrays" (not supported on bash of macOS)

if [[ ! -d "$1" ]]; then
	echo "Usage: arr2 dir" >&2
	exit 1
fi

for i in "$1"/*; do
	owner=$(stat -f "%Su" "$i")
	group=$(stat -f "%Sg" "$i")
	files["$i"]="$i"
	file_owner["$i"]=$owner
	file_group["$i"]=$group
	((++owners[$owner]))
	((++groups[$group]))
done

{
for i in "${files[@]}"; do
	printf "%-40s %-10s %-10s\n" "$i" ${file_owner["$i"]} ${file_group["$i"]}
done 
} | sort      # use group cmds to combine all the outputs and pip then to the input of sort
echo          # used for print a newline

echo "File owners:"
{
	for i in "${!owners[@]}"; do      # get the index of the arr, but does not work on zsh
		printf "%-10s: %5d file(s)\n" "$i" ${owners["$i"]}
	done
} | sort
echo


echo "File group onwers:"
{
	for i in "${!groups[@]}"; do
        printf "%-10s: %5d file(s)\n" "$i" ${groups["$i"]}
    done
} | sort
