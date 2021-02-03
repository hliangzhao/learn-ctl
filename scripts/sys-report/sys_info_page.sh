#!/bin/bash
TITLE="System Report for Host $HOSTNAME"
CURRENT_TIME=$(date)
TIME_STAMP="Generated at $CURRENT_TIME, by $USER"

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

cat << _EOF_
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
