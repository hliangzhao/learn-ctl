## 二、配置文件和shell环境
1、shell在环境中存储了两种基本类型的变量，分别是**环境变量**和**shell变量**。此外，shell也存储了一些可编程的数据，即**别名**（alias）和shell函数。

2、通过`set`查看所有变量，使用`printenv`查看环境变量。`printenv VAR=NAME`和`echo $VAR-NAME`具有相同的效果。常见的环境变量：
```shell
(base) ➜  playground printenv SHELL
/bin/zsh
(base) ➜  playground printenv PAGER       # 页输出程序的名字
less
(base) ➜  playground printenv PWD
/Users/hliangzhao/Documents/Codes/playground
(base) ➜  playground printenv TERM
xterm-256color
```

3、用`alias`查看所有别名。

4、当我们登录系统后，bash程序启动，并且会读取一系列称为启动文件的配置脚本，这些文件定义了默认的可供所有用户共享的shell环境。然后是读取更多位于我们自己家目录中的启动文件，这些启动文件定义了用户个人的shell环境。确切的启动顺序依赖于要运行的shell会话（session）类型。有两种shell会话类型：

- 登录shell会话：启动一个虚拟控制台会话（先启动全局的`/etc/profile`，再启动`~/.bash_profile` ➜ `~/.bash_login` ➜ `~/.profile`）。
- 非登录shell会话：在某GUI程序内启动终端会话（先启动全局的`/etc/bashrc`，再启动`~/.zshrc`）。除了读取以上启动文件之外，非登录shell会话也会继承它们父进程的环境设置，通常是一个登录shell（在`~/.zshrc`中有`source ~/.bash_profile`的命令）。

5、对于我们输入的任意命令，shell会从一个列表中查询该命令是否存在，这个列表包含在`PATH`变量中。通过代码`PATH=$PATH:cmd-path`将路径位于`cmd-path`的命令添加到`PATH`变量中。这个代码风格是“追加赋值”。`cmd-path`当然也可以允许出现可展开的变量，例如`PATH=$PATH:$HOME/bin`将位于用户家目录中的`bin`目录添加到命令搜索范围内。

6、按照通常的规则，添加目录到你的`PATH`变量或者是定义额外的环境变量，要把这些更改放置到`.bash_profile`文件中（或者其替代文件中，例如Ubuntu使用`.profile`文件）。对于其它的更改，要放到`.bashrc`文件中。除非你是系统管理员，需要为系统中的所有用户修改默认设置，那么则限定你只能对自己家目录下的文件进行修改。