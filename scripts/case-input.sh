#!/bin/bash
while read -p "Enter word: "; do
	case $REPLY in
		[[:alpha:]])	echo "This is a single alphabetic char." ;;
		[ABC][0-9])		echo "This is A, B, or C followed by a digit." ;;
		???)			echo "This is three chars long." ;;
		*.txt)			echo "This is a word ending in '.txt'" ;;
		exit|EXIT)		break ;;     # match more than one pattern
		*)				echo "This is sth. else." ;;
	esac
done
echo "Terminated."
