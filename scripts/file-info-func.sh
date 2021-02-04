# file_info: function to display file information
file_info () {
	local count=1
	while (( $# > 0 )); do
		if [[ -e $1 ]]; then
    		echo "----------------\nFile Type:"
    		file $1
    		echo "\nFile Status:"
    		stat $1
			shift
		else
    		echo "$FUNCNAME: usage: $FUNCNAME file" >&2
    		break
		fi
	done
}

file_info assign.sh distros.txt
