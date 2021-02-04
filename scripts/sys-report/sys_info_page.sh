#!/bin/bash
TITLE="System Report for Host $HOSTNAME"
CURRENT_TIME=$(date)
TIME_STAMP="Generated at $CURRENT_TIME, by $USER"
PROGNAME=$(basename $0)

function report_uptime {
	cat <<- _EOF_
	<h2>Uptime</h2>
	<pre>$(uptime)</pre>
	_EOF_
}

report_disk_usage() {
	cat <<- _EOF_
	<h2>Disk Usage</h2>
	<pre>$(df -h)</pre>
	_EOF_
}

report_home_space() {
	if [[ $(id -u) -eq 0 ]]; then
		cat <<- _EOF_
		<h2>Home Space for All Users</h2>
		<pre>$(du -sh /Users/*)</pre>
		_EOF_
	else
		cat <<- _EOF_
		<h2>Home Space for $USER</h2>
		<pre>$(du -sh /Users/$USER/*)</pre>
		_EOF_
	fi
}

usage() {
	echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
	return
}

write_html_page() {
	cat <<- _EOF_
	<html>
    	<head>
        	<title>$TITLE</title>
    	</head>
    	<body>
        	<h1>$TITLE</h1>
        	<p>$TIME_STAMP</p>
        	$(report_uptime)
        	$(report_disk_usage)
        	$(report_home_space)
    	</body>
	</html>
	_EOF_
	return
}

interactive=
filename=

# process cmd line options
while [[ -n $1 ]]; do
	case $1 in 
	-f | --file)
		shift
		filename=$1      # after shift, $1 is the real filename, rather than "-f" or "--file"
		;;
	-i | --interactive)
		interactive=1
		;;
	-h | --help)
		usage
		exit
		;;
	*)
		usage >&2
		exit 1
		;;
	esac
	shift
done

# interactive mode
if [[ -n $interactive ]]; then
	while true; do
		read -p "Enter name of output file: " filename
		if [[ -e $filename ]]; then
			read -p "'$filename' exists. Overwrite? [y/n/q]: "
			case $REPLY in
			y|Y)
				break
				;;
			q|Q)
				echo "Program terminated."
				exit
				;;
			*)
				continue
				;;
			esac
		elif [[ -z $filename ]]; then
			continue
		else
			break
		fi
	done
fi

# after break out the while-loop, write the html page here
if [[ -n $filename ]]; then
	# if the file exists, test it is writable or not
	# if the file is non-exist, the filename should be a legal filepath, thus we can create it
	if touch $filename && [[ -f $filename ]]; then
		write_html_page > $filename
		echo "Successfully write to '$filename'."
	else
		echo "$PROGNAME: cannot write file '$filename'." >&2
		exit 1
	fi
else
	write_html_page
fi
