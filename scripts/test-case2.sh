#!/bin/bash
# case4-2: test a character (if /bin/zsh then error happens)
read -n 1 -p "Type a character > "
echo
case $REPLY in
    [[:upper:]])    echo "'$REPLY' is upper case." ;;&   # bash version < 4 will throw an error
    [[:lower:]])    echo "'$REPLY' is lower case." ;;&
    [[:alpha:]])    echo "'$REPLY' is alphabetic." ;;&
    [[:digit:]])    echo "'$REPLY' is a digit." ;;&
    [[:graph:]])    echo "'$REPLY' is a visible character." ;;&
    [[:punct:]])    echo "'$REPLY' is a punctuation symbol." ;;&
    [[:space:]])    echo "'$REPLY' is a whitespace character." ;;&
    [[:xdigit:]])   echo "'$REPLY' is a hexadecimal digit." ;;&
esac

