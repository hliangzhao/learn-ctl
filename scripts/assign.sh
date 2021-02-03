# define variables and refer them
a=z
b="a string"
c='a string and $b'
c1="a string and $b"
d=$(ls /usr/local/bin)
e=$((6 * 7))
f='\t\ta string\n'

echo $a"\n"$b"\n"$c"\n"$d"\n"$e"\n"$f
