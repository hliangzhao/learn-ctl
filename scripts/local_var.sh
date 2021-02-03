#!/bin/zsh
foo=0

func1() {
	local foo
	foo=1
	echo "func1: foo = $foo"
}

echo "global: foo = $foo"
func1
echo "global: foo = $foo"
