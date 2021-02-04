x=5
if [ $x = 5 ]; then
	echo "x equal to 5"
	echo "x * 5 = $((x * 5))"    # x and $x are both acceptable
else
	echo "x does not equal 5"
fi
