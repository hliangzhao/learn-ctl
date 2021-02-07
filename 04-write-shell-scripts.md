## 编写shell脚本

1、使用变量

（1）我们怎样来创建一个变量呢？很简单，我们只管使用它。当 shell 碰到一个变量的时候，它会 自动地创建它。这不同于许多编程语言，它们中的变量在使用之前，必须显式的声明或是定义。关于 这个问题，shell 要求非常宽松，这可能会导致一些问题。

（2）如果`foo`是一个不存在的变量，则`echo $foo`会输出一个空值。这是因为当 shell 遇到 `foo`的时候, 它很高兴地创建了变量`foo`并且赋给他一个空的默认值！

（3）变量的命名规则：
- 变量名可由字母数字字符（字母和数字）和下划线字符组成。
- 变量名的第一个字符必须是一个字母或一个下划线。
- 变量名中不允许出现空格和标点符号。

（4）shell 不能辨别变量和常量；它们大多数情况下是为了方便程序员。一个常用惯例是指定大写字母来表示常量，小写字母表示真正的变量。实际上，shell确实提供了一种方法，通过使用带有`-r`（只读）选项的内部命令`declare`，来强制常量的不变性。例如，`declare -r TITLE=”Page Title”`将阻止一切给`TITLE`的赋值。然而，这个功能极少被使用。

（5）通过`var=val`给变量赋值。shell不会在乎变量值的类型，**它把它们都看作是字符串**。
在赋值过程中，变量名、等号和变量值之间必须没有空格。`val`是可以展开成字符串的anything。

（6）使用`{}`限定变量名：
```shell
[me@linuxbox ~]$ filename="myfile"
[me@linuxbox ~]$ touch $filename
[me@linuxbox ~]$ mv $filename $filename1  #  shell 把 mv 命令的第二个参数解释为一个新的（并且空的）变量
mv: missing destination file operand after `myfile'
Try `mv --help' for more information.
[me@linuxbox ~]$ mv $filename ${filename}1
```

（7）一种常见的操作时使用命令替换来赋值变量。下面例子中，`CURRENT_TIME`使用命令替换定义的，通过`$CURRENT_TIME`即可展开该变量内部的命令。
```shell
CURRENT_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"
$TIME_STAMP
```
下面这个例子可以简单地理解为`cat $(du -sh /home/*)`
```shell
report_home_space () {
  cat <<- _EOF_
  <H2>Home Space Utilization</H2>
  <PRE>$(du -sh /home/*)</PRE>
  _EOF_
  return
}
```

2、我们已经知道了两种不同的文本输出方法，两种方法都使用了`echo`命令。还有第三种方法，叫做 here document 或者 here script。

（1）一个 here document 是另外一种 I/O 重定向形式，我们 在脚本文件中嵌入正文文本，然后把它发送给一个命令（常用的是`cat`）的标准输入：
```
cat <<- _EOF_
    text
_EOF_
```

（2）默认情况下，here documents 中的**单引号和双引号会失去它们在 shell 中的特殊含义**。
```shell
[me@linuxbox ~]$ foo="some text"   # 这里加上了引号，但是不会被输出
[me@linuxbox ~]$ cat << _EOF_
> $foo
> "$foo"
> '$foo'
> \$foo
> _EOF_
some text
"some text"
'some text'
$foo
```
因此，我们可以在一个 here document 中可以随意的嵌入引号。

3、shell函数

（1）两种定义方式：
```shell
function name {
    commands
    return
}
```
```shell
name () {
    commands
    return
}
```
直接用`name`调用名为`name`的函数。注意，为了使函数调用被识别出是 shell 函数，而不是被解释为外部程序的名字，在脚本中 shell 函数定义必须出现在函数调用之前。

（2）用`local var`或`local var=val`在shell函数内声明局部变量。

4、使用选择分支

（1）`if`语法结构
```shell
if commands; then
     commands
[elif commands; then
     commands...]
[else
     commands]
fi
```

（2）与`if`一块使用的命令是`test`，可用`test expression`或`[ experission ]`来使用该命令。这里的 expression 是一个表达式，其执行结果是 true 或者是 false。**当表达式为真时，这个 test 命令返回一个0退出状态，当表达式为假时，test 命令退出状态为1。**

```shell
# 下面给出test.sh的内容
#!/bin/bash
FILE=~/.bashrc
if [ -e "$FILE" ]; then
    if [ -f "$FILE" ]; then
        echo "$FILE is a regular file."
    fi
else
    echo "$FILE does not exist"
    exit 1
fi
exit
```
上面的例子中，在表达式中引用变量我们加上引号。引号并不是必需的，但这是为了防范空参数。如果`$FILE`的参数展开是一个空值，就会导致一个错误。但如果加上引号，操作符将会被解释为非空的字符串。这就确保了操作符之后总是跟随着一个字符串，即使字符串为空。

此外，注意脚本末尾的`exit`命令。 这个`exit`命令接受一个单独的，可选的参数，其成为脚本的退出状态。当不传递参数时，退出状态默认为零。以这种方式使用`exit`命令，则允许此脚本提示失败如果`$FILE`展开成一个不存在的文件名。这个`exit`命令出现在脚本中的最后一行，是一个当一个脚本“运行到最后”（到达文件末尾），不管怎样，默认情况下它以退出状态零终止。

类似地，在shell函数内可食用带有一个整数参数的`return`命令，从而让该函数返回一个退出状态。

（3）各种表达式

**用于测试文件的`test`表达式：**
表达式 | 如果下列条件为真则返回True
--- | ---
`file1 -ef file2` | file1 和 file2 拥有相同的索引号（通过硬链接两个文件名指向相同的文件）。
`file1 -nt file2` | file1新于 file2。
`file1 -ot file2` | file1早于 file2。
`-b file` | file 存在并且是一个块（设备）文件。
... | ...

完整列表通过`man test`查阅。

**用于测试字符串的`test`表达式：**
表达式 | 如果下列条件为真则返回True
--- | ---
`string` | string 不为 null。
`-z string` | 字符串 string 的长度为零。
`-n string` | 字符串 string 的长度大于零。
`string1 = string2`或`string1 == string2` | string1 和 string2 相同。双等号更受欢迎。
... | ...

此外还有用于测试整数的，不再赘述。

**注意：用于测试文件和测试字符串的`test`表达式中，引用变量时最好加上双引号，在测试整数的`test`表达式中则不需要。**

（4）目前的 bash 版本包括一个复合命令，作为加强的 test 命令替代物。即`[[ expression ]]`。这里，类似于`test`，`expression`是一个表达式，其计算结果为真或假。这个`[[ ]]`命令非常相似于`test`命令（它支持所有的表达式），但是增加了如下特性：
- 一个重要的新的字符串表达式：`string1 =~ regex`。如果`string1`匹配扩展的正则表达式`regex`则其返回值为真。e.g.，`if [[ "$INT" =~ ^-?[0-9]+$ ]]; then xxx; fi`。**此处`regex`不能加引号**。
- 用`==`操作符支持类型匹配，正如路径名展开所做的那样。e.g.，`if [[ $FILE == foo.* ]]; then xxx; fi`。**此处待展开的路径名不能加引号，但变量无所谓**。

（5）除了`[[ ]]`，还可用`(( ))`来专门针对整数执行算术真测试。如果算术计算的结果是非零值，则其测试值为真。
```shell
[me@linuxbox ~]$ if ((1)); then echo "It is true."; fi
It is true.
[me@linuxbox ~]$ if ((0)); then echo "It is true."; fi
[me@linuxbox ~]$
```
**因为复合命令`(( ))`是 shell 语法的一部分，而不是一个普通的命令，而且它只处理整数，所以它能够通过名字识别出变量，而不需要执行展开操作。**
下面给出了一个示例：
```shell
#!/bin/bash
# test-integer2a: evaluate the value of an integer.
INT=-5
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if ((INT == 0)); then    # 不需要展开符$
        echo "INT is zero."
    else
    if (( ((INT % 2)) == 0)); then   # 不需要展开符$
            echo "INT is even."
    fi
fi
```

（6）在`test`、[[ ]]`和`(( ))`中使用逻辑运算符 AND、OR 和 NOT。
操作符 | `test` | `[[ ]]` and `(( ))`
--- | --- | ---
AND | `-a` | `&&`
OR | `-o` | `||`
NOT | `!` | `!`
```shell
if [[ "$INT" =~ ^-?[0-9]+$ ]]; then
    if [[ INT -ge MIN_VAL && INT -le MAX_VAL ]]; then
        echo "$INT is within $MIN_VAL to $MAX_VAL."
    fi
fi
```

我们也可以对表达式使用圆括号来分组（圆括号必须**引起来**或者是**转义**）。如果不使用括号，那么否定只应用于第一个表达式，而不是两个组合的表达式。
```shell
if [ ! \( $INT -ge $MIN_VAL -a $INT -le $MAX_VAL \) ]; then
    echo "$INT is outside $MIN_VAL to $MAX_VAL."
else
    echo "$INT is in range."
fi
```
因为`test`使用的所有的表达式和操作符都被 shell 看作是命令参数，所以对于 bash 有特殊含义的字符，比如说`<`，`>`，`(`，和`)`，必须**引起来**或者是**转义**。

（7）使用控制操作符`&&`和`||`来实现简易的分支结构（非常重要的、提升鲁棒性的编程方法）：

- `mkdir temp && cd temp`：这会创建一个名为 temp 的目录，并且若它执行成功后，当前目录会更改为 temp。第二个命令会尝试 执行只有当 mkdir 命令执行成功之后。
- `[ -d temp ] || exit 1`：这会测试目录 temp 是否存在，并且只有测试失败之后，才会创建这个目录。

5、当命令执行完毕后，命令（包括我们编写的脚本和 shell 函数）会给系统发送一个值，叫做退出状态。 这个值是一个 0 到 255 之间的整数，说明命令执行成功或是失败。按照惯例，一个零值说明成功，其它所有值说明失败。使用`echo $?`查看上一个命令的退出状态。

6、读取键盘输入

（1）使用`read [-options] [variable...]`从标准输入中读取数据。
其中`variable`是用来存储输入数值的一个或多个变量名。如果没有提供变量名，shell变量`REPLY`会包含数据行。如果`read`命令接受到变量值数目少于期望的数字（即指定的`variable`的个数），那么额外的变量值为空，而**多余的输入数据则会被包含到最后一个变量中**。

`read`的options：
选项 | 说明
--- | ---
`-a array` | 把输入赋值到数组 array 中，从索引号零开始。我们 将在第36章中讨论数组问题。
`-d delimiter` | 用字符串 delimiter 中的第一个字符指示输入结束，而不是一个换行符。
`-e`|使用 Readline 来处理输入。这使得与命令行相同的方式编辑输入。
`-n num`|读取 num 个输入字符，而不是整行。
`-p prompt`|为输入显示提示信息，使用字符串 prompt。
`-r`|Raw mode. 不把反斜杠字符解释为转义字符。
`-s`|Silent mode. 不会在屏幕上显示输入的字符。当输入密码和其它确认信息的时候，这会很有帮助。
`-t seconds`|超时. 几秒钟后终止输入。若输入超时，read 会返回一个非零退出状态。
`-u fd`|使用文件描述符 fd 中的输入，而不是标准输入。

（2）通常，shell对提供给`read`的输入按照单词进行分离。正如我们所见到的，这意味着多个由一个或几个空格分离开的单词在输入行中变成独立的个体，并被`read`赋值给单独的变量。这种行为由`shell`变量`__IFS__`（内部字符分隔符）配置。`IFS`的默认值包含一个空格，一个tab，和一个换行符，每一个都会把字段分割开。我们可以调整`IFS`的值来控制输入字段的分离。

```shell
FILE=/etc/passwd
read -p "Enter a user name > " user_name
file_info=$(grep "^$user_name:" $FILE)
IFS=":" read user pw uid gid name home shell <<< "$file_info"
```
这里，在`read`命令前、但是是在同一行赋值变量`IFS`，其含义是**这些赋值会暂时改变之后的命令的环境变量**，但对后面的命令则无影响。此外，`<<<`操作符指示一个 here 字符串。一个 here 字符串就像一个 here 文档，只是比较简短，由单个字符串组成。在这个例子中，来自`/etc/passwd`文件的数据发送给`read`命令的标准输入。

在`read`中我们不使用管道（如`echo "$file_info" | IFS=":" read user pw uid gid name home shell`），这是因为管道线 会创建子 shell。这个子 shell 是为了执行执行管线中的命令而创建的shell和它的环境的副本。上面示例中，`read`命令将在子 shell 中执行。在类 Unix 的系统中，子 shell 执行的时候，会为进程创建父环境的副本。当进程结束 之后，该副本就会被破坏掉。这意味着一个子 shell 永远不能改变父进程的环境。`read`赋值变量，然后会变为环境的一部分。在上面的例子中，`read`在它的子 shell 环境中，把`foo`赋值给变量`REPLY`，但是当命令退出后，子 shell 和它的环境将被破坏掉，这样赋值的影响就会消失。而here字符串是解决此问题的一种方法。

7、使用`while`循环

`while`循环的格式：
```shell
while test-condition; do
    do sth.
done
```

`until`循环的格式：
```shell
until test-condition; do
    do sth.
done
```
这里`test-condition`常常用test表达式。此外，`break`和`continue`的使用同大多数编程语言一样。

8、`case`的模式

模式|描述
---|---
`a)`|若单词为 “a”，则匹配
`[[:alpha:]])`|若单词是一个字母字符，则匹配
`???)`|若单词只有3个字符，则匹配
`*.txt)`|若单词以 “.txt” 字符结尾，则匹配
`*)`|匹配任意单词。把这个模式做为 case 命令的最后一个模式，是一个很好的做法， 可以捕捉到任意一个与先前模式不匹配的数值；也就是说，捕捉到任何可能的无效值。

若输入的字符不止与一个 POSIX 字符集匹配的话可能会出错，使用`;;&`（即加上`&`）来终止下一个case的匹配。

9、使用`#!/bin/bash -x`或`set -x`对程序进行追踪，从而找到bug。

10、使用`for`循环

**一般格式：**
```shell
for variable [in words]; do
    commands
done
```
其中，`words`是一个可选的条目列表，它可以通过许多有趣的方式创建（各种展开操作）。

**C语言格式：**
```shell
for (( expression1; expression2; expression3 )); do
    commands
done
```

11、使用位置参数

（1）执行shell脚本时连带键入的参数被称为未知参数，用`$i`获取。其中`$0`是脚本（命令）名，`$i`获取第i个未知参数。用`$#`获取全部位置参数的个数（从1开始算起）。

（2）使用`shift`将所有的位置参数“向下移动一个位置”，从而只需通过`$1`即可依次处理每一个位置参数。

（3）使用`basename`命令清除一个路径名的开头部分，只留下一个文件的基本名称。

（4）把所有的位置参数作为一个集体来管理。下面的例子中，将`$*`和`$@`作为下一级命令print_params的参数传递给print_params。`$*`和`$@`本身得到的是`"word" "words with spaces"`。毒刺它们有略微不同的处理方式：

参数|描述
---|---
`$*`|展开成一个从1开始的位置参数列表。当它被用双引号引起来的时候，展开成一个由双引号引起来 的字符串，包含了所有的位置参数，每个位置参数由 shell 变量 IFS 的第一个字符（默认为一个空格）分隔开。
`$@`|展开成一个从1开始的位置参数列表。当它被用双引号引起来的时候， 它把每一个位置参数展开成一个由双引号引起来的分开的字符串。

```shell
#!/bin/bash
# posit-params3 : script to demonstrate $* and $@
print_params () {
    echo "\$1 = $1"
    echo "\$2 = $2"
    echo "\$3 = $3"
    echo "\$4 = $4"
}
pass_params () {
    echo -e "\n" '$* :';      print_params   $*
    echo -e "\n" '"$*" :';    print_params   "$*"
    echo -e "\n" '$@ :';      print_params   $@
    echo -e "\n" '"$@" :';    print_params   "$@"
}
pass_params "word" "words with spaces"
```

12、参数展开的详细描述，包括
- 基本的参数展开：`$a`、`${a}`
- 管理空变量的展开：`${parameter:-word}`、`${parameter:=word}`、`${parameter:?word}`、`${parameter:+word}`
- 返回变量名的参数展开：`${!prefix*}`、`${!prefix@}`
- 字符串展开：`${#parameter}`返回字符串长度、用于数组则返回数组元素个数、`{parameter:offset:length`提取部分字符（`length`不是必须的）、`${parameter#pattern}`或`${parameter##pattern}`从paramter所包含的字符串中清除开头一部分文本（将`#`换成`%`则从字符串末尾开始清除）、`${parameter/pattern/string}`及其变种进行查找替换操作
- 使用`declare`命令可以用来把字符串规范成大写或小写字符（`declare -u upper`及`declare -l lower`）
- 算术求值与展开：简单运算、设定基底、位运算符及逻辑运算符、赋值操作、使用`bc`实现复杂运算

涉及管理空变量的展开、返回变量名的展开、字符串展开、大小写转换等，详见[《字符串和数字》](http://billie66.github.io/TLCL/book/chap35.html)。

13、灵活使用数组，包括
- 数组的创建、赋值、访问
- 输出整个数组的内容（使用`${arrname[*]}`或``${arrname[@]}``）
- 确定数组元素的个数（使用`${#arrname[*]}`）
- 找到数组使用的下标（使用`${!arrname[*]}`或``${!arrname[@]}``）
- 使用`+=`在数组末尾添加元素
- 使用`sort`对数组进行排序（`a_sorted=($(for i in "${a[@]}"; do echo $i; done | sort))`）
- 使用`unset`删除数组或数组元素
- 使用关联数组（键值对）

详见[《数组》](http://billie66.github.io/TLCL/book/chap36.html)。

14、一些不曾涉及的知识，包括
- 组命令和子shell
- 进程替换
- 使用`trap`捕捉信号并作出响应
- 创建不可预测文件名的临时文件（`mktemp`）
- 异步执行
- 命名管道

详见[《奇珍异宝》](http://billie66.github.io/TLCL/book/chap37.html)。