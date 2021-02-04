# define variables and refer them
a=z     # as a string
b="a string"
c='a string and $b'
c1="a string and $b"
d="$(ls -l /usr/local/bin)"     # cmd expansion
e=$((6 * 7))
f='\t\ta string\n'

echo $a"\n"$b"\n"$c"\n"$c1"\n$d\n"$e"\n"$f
