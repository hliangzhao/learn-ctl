#!/bin/bash
# count files by the modification time
usage() {
	echo "usage: $(basename $0) dir" >&2
}

if [[ ! -d $1 ]]; then
	usage
	exit 1
fi

for i in {0..23}; do
	hours[i]=0
done

for i in $(stat -f "%m%t%Sm %N" "$1"/* | cut -d " " -f 4 | cut -d : -f 1); do
	j=${i/#0}    # remove the 0 at the beginning becasue 00-09 will be taken as octal by bash
	((++hours[j]))
	((++count))
done

echo -e "Hour\tFiles\tHour\tFiles"
echo -e "----\t-----\t----\t-----"
for i in {0..11}; do
	j=$((i+12))
	printf "%02d\t%d\t%02d\t%d\n" $i ${hours[i]} $j ${hours[j]}
done
printf "\nTotal files = %d\n" $count
