#!/bin/zsh
# test.sh: evaluate the status of file
# FILE=~/.bash_profile
if [ -e $FILE ]; then       # " " is not necessary, but can be used to avoid empty param
	if [ -f "$FILE" ]; then
		echo "$FILE is a regular file."
	fi
	if test -f "$FILE"; then                # '[ cmd ]' equals to 'test cmd'
		echo "$FILE is a regular file."
		if [ "$FILE" -ef "~/.zshrc" ]; then
			echo "$FILE is equal to ~/.zshrc."
		else
			echo "$FILE is not equal to ~/.zshrc."
		fi
	fi
	if [ -d "$FILE" ]; then
		echo "$FILE is a directory."
	fi
	if [ -r "$FILE" ]; then
		echo "$FILE is readable."
	fi
	if [ -w "$FILE" ]; then
		echo "$FILE is writable."
	fi
	if [ -x "$FILE" ]; then
		echo "$FILE is executable."
	fi
else
	echo "$FILE does not exists."
fi


# analyze the following output
if [ -e $FILE1 ]; then 
	echo "$FILE1 exists."
else
	echo "$FILE1 not exists."
fi

if [ -e "$FILE1" ]; then
    echo "$FILE1 exists."
else
    echo "$FILE1 not exists."
fi

exit
