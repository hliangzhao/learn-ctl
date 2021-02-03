#!/bin/zsh
# shebang is not necessary
# two ways to define functions
function func2 {
	echo "Step 2"
	return
}

func4() {
	echo "Step 4"     # return is not necessary
}

echo "Step 1"
func2                 # write func name to call it
echo "Step 3"
func4
