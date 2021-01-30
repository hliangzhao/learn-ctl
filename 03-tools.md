## 常见任务和基本工具
- [常见任务和基本工具](#常见任务和基本工具)
  - [软件包管理](#软件包管理)
  - [存储和网络](#存储和网络)
  - [查找、压缩和归档](#查找压缩和归档)
  - [正则表达式](#正则表达式)
  - [文本处理](#文本处理)
  - [编译](#编译)

### 软件包管理
1、软件包管理是指系统中一种安装和维护软件的方法。今天，通过从**Linux发行版**中安装的软件包，已能满足许多人所有的软件需求。这不同于早期的Linux，人们需要下载和编译源码来安装软件。编译源码没有任何问题，事实上，拥有对源码的访问权限是Linux的伟大奇迹。它赋予我们检测和提高系统性能的能力。只是若有一个预先编译好的软件包处理起来要相对容易快速些。

2、不同的Linux发行版使用不同的打包系统，一般而言，大多数发行版分别属于两大包管理技术阵营：Debian的`.deb`和红帽的`.rpm`。
| 包管理系统 |  发行版（部分列表）
| --- | ---
| Debian Style (`.deb`) | Debian, Ubuntu, Xandros, Linspire
|Red Hat Style (`.rpm`) | Fedora, CentOS, Red Hat Enterprise Linux, OpenSUSE, Mandriva, PCLinuxOS

3、软件管理<br>
（1）Linux系统中几乎所有的软件都可以在互联网上找到。其中大多数软件由发行商以**包文件**的形式提供，剩下的则以源码形式存在，可以手动安装。

（2）在包管理系统中，软件的基本单元是包文件。**包文件是一个构成软件包的文件压缩集合。**
一个软件包可能由大量程序以及支持这些程序的数据文件组成。除了安装文件之外，软件包文件也包括关于这个包的元数据，如软件包及其内容的文本说明。另外，许多软件包还包括预安装和安装后脚本，这些脚本用来在软件安装之前和之后执行配置任务。

（3）通常，软件包维护者从上游提供商（程序作者）那里得到软件源码，然后编译源码，创建软件包元数据以及所需要的安装脚本。

（4）程序很少独立工作；它们需要依靠其他程序的组件来完成他们的工作。程序所共有的活动，如输入/输出，就是由一个被多个程序调用的子例程处理的。这些子例程存储在**动态链接库**中。动态链接库为多个程序提供基本服务。如果一个软件包需要一些共享的资源，如一个动态链接库，它就被称作有一个依赖。现代的软件包管理系统都提供了一些依赖项解析方法，以确保安装软件包时，其所有的依赖也被安装。

（5）软件包管理系统通常由两种工具类型组成：底层工具和上层工具。
- 底层工具：安装和删除软件包文件；
- 上层工具：元数据搜索和依赖解析。

| 发行版 | 底层工具 | 上层工具
| --- | --- | ---
| Debian-Style | dpkg | apt-get, aptitude
| Fedora, Red Hat Enterprise Linux, CentOS | rpm | yum

（6）使用上层工具查找资源库中的软件包，例如`yum search emacs`：
| 风格 | 命令
| --- | ---
| Debian | `apt-get update; apt-cache search search_string`
| Red Hat | `yum search search_string`

（7）上层工具允许从一个资源库中下载一个软件包，并经过完全依赖解析来安装它。通过包名安装，例如`yum install emacs`。
| 风格 | 命令
| --- | ---
| Debian | `apt-get update; apt-get install package_name`
| Red Hat | `yum install package_name`

（8）如果已从并非资源库的网站下载了软件包文件，则可以通过底层工具直接安装它（不经过依赖解析，缺少依赖则直接报错退出）。例如`rpm -i emacs-22.1-7.fc7-i386.rpm`。
| 风格 | 命令
| --- | ---
| Debian | `dpkg --install package_file`
| Red Hat | `rpm -i package_file`

（9）卸载软件包：
| 风格 | 命令
| --- | ---
| Debian | `apt-get remove package_name`
| Red Hat | `yum erase package_name`

（10）要保持系统中的软件包都是最新的，可以先从资源库网站update本地列表，然后通过upgrade命令更新包：
| 风格 | 命令 
| --- | ---
| Debian | `apt-get update; apt-get upgrade`
| Red Hat | `yum update`

也可通过底层工具更新（需提前下载包的新版本）：
| 风格 | 命令
| --- | ---
| Debian | `dpkg --install package_file`（和安装的命令一样）
| Red Hat | `rpm -U package_file`

（11）列出安装了的包：
| 风格 | 命令
| --- | ---
| Debian | `dpkg --list`
| Red Hat | `rpm -qa`

（12）确认是否安装了指定的包：
| 风格 | 命令
| --- | ---
| Debian | `dpkg --status package_name`
| Red Hat | `rpm -q package_name`

（13）显示某个软件包的信息：
| 风格 | 命令
| --- | ---
| Debian | `apt-cache show package_name`
| Red Hat | `yum info package_name`

（14）确定哪个软件包对所安装的某个特殊文件负责：
| 风格 | 命令
| --- | ---
| Debian | `dpkg --search file_name`
| Red Hat | `rpm -qf file_name`

（15）Linux软件生态系统是基于开放源代码理念。如果一个程序开发人员发布了一款产品的源码，那么与系统发行版相关联的开发人员可能就会把这款产品打包，并把它包含在他们的资源库中。这种方法保证了这款产品能很好地与系统发行版整合在一起，同时为用户“一站式采购”软件提供了方便，从而用户不必去搜索每个产品的网站。

### 存储和网络
4、存储媒介<br>
（1）管理存储设备的常用命令：
- `mount` – 挂载一个文件系统
- `umount` – 卸载一个文件系统
- `fsck` – 检查和修复一个文件系统
- `fdisk` – 分区表控制器
- `mkfs` – 创建文件系统
- `fdformat` – 格式化一张软盘
- `dd` — 把面向块的数据直接写入设备
- `genisoimage (mkisofs)` – 创建一个ISO 9660的映像文件
- `wodim (cdrecord)` – 把数据写入光存储媒介
- `md5sum` – 计算MD5检验码

（2）大多数情况下，我们只要把设备连接到系统中，它就能工作。但是，对于有极端的存储需求和复杂的配置要求的服务器，仍然需要手动进行设备管理。
**管理存储设备的第一步是把设备连接到文件系统树中。这个叫做”挂载”的过程允许设备连接到操作系统中。**
类Unix的操作系统，比如Linux，在单一文件系统树中维护连接在各个节点的各种设备。这与其它操作系统形成对照，比如说MS-DOS和Windows系统中，每个设备（例如`C:\`，`D:\`，等）保持着单独的文件系统树。

（3）查看`/etc/fstab`列出系统启动时要挂载的设备。在下面的例子中，
```shell
LABEL=/12               /               ext3        defaults        1   1
LABEL=/home             /home           ext3        defaults        1   2
LABEL=/boot             /boot           ext3        defaults        1   2
```
6个字段依次为：
| 字段 | 内容 | 说明
| --- | --- | ---
| 1 | 设备名 | 传统上，这个字段包含与物理设备相关联的设备文件的实际名字，比如说`/dev/hda1`（第一个IDE通道上第一个主设备分区）。然而今天的计算机，有很多热插拔设备（像USB驱动设备），因此许多现代的Linux发行版用一个文本标签和设备相关联。当这个设备连接到系统中时， 这个标签（当储存媒介格式化时，这个标签会被添加到存储媒介中）会被操作系统读取。 那样的话，不管赋给实际物理设备哪个设备文件，这个设备仍然能被系统正确地识别。
| 2 | 挂载点 | 设备所连接到的文件系统树的目录。
| 3 | 文件系统类型 | Linux允许挂载许多文件系统类型。大多数本地的Linux文件系统是ext3，但是也支持很多其它的，比方说FAT16（msdos)），FAT32（vfat），NTFS（ntfs），CD-ROM（iso9660）等等。
| 4 | 选项 | 文件系统可以通过各种各样的选项来挂载。例如，挂载只读的文件系统或者挂载阻止执行任何程序的文件系统（出于安全考虑）
| 5 | 频率 | 一位数字，指定是否和在什么时间用dump命令来备份一个文件系统。
| 6 | 次序 | 一位数字，指定`fsck`命令按照什么次序来检查文件系统。

（4）执行`mount`（或`df`）查看挂载的文件系统列表：
```shell
(base) ➜  playground mount
/dev/disk1s5 on / (apfs, local, read-only, journaled)
devfs on /dev (devfs, local, nobrowse)
/dev/disk1s1 on /System/Volumes/Data (apfs, local, journaled, nobrowse)
/dev/disk1s4 on /private/var/vm (apfs, local, journaled, nobrowse)
map auto_home on /System/Volumes/Data/home (autofs, automounted, nobrowse)
```

简单来看，挂载就是将一个物理存储设备和文件系统内某个目录关联起来，这样我们就可以通过访问这个目录来访问这个物理设备内的文件。通常挂载是在我们插入一个物理设备时默认进行的，但是我们也可以手动设置挂载点、手动卸载设备。

（5）缓存被广泛地应用于计算机中，使其运行得更快。
**别让偶尔地的读取或写入慢设备的需求阻碍了系统的运行速度。**
在真正与比较慢的设备交互之前，操作系统会尽可能多的读取或写入数据到内存中的存储设备里。以Linux操作系统为例，你会注意到系统看似填充了多于它所需要的内存。这不意味着Linux正在使用所有的内存，它意味着Linux正在利用所有可用的内存来作为缓存区。这个缓存区允许非常快速地对存储设备进行写入，因为写入物理设备的操作被延迟到后面进行。同时，这些注定要传送到设备中的数据正在内存中堆积起来。时不时地，操作系统会把这些数据写入物理设备。卸载一个设备时需要把所有剩余的数据写入这个设备，这样设备才可以被安全地移除。如果不卸载设备就直接把插头，在某些情况下可能会导致文件损坏。这是因为未写完的数据可能包含重要的目录更新信息，导致了文件系统的损坏。

（6）假设我们有一个闪存驱动器（flash drive）已经挂载到了目录`/mnt/flash`上，其中`/dev/sdb`是设备名，`/dev/sdb1`是设备的第一分区：
```shell
[me@busybox ~]$ df
/dev/sdb1       15560       0           15560       0%      /mnt/flash
```
现在我们想要用Linux本地文件系统来重新格式化这个闪存驱动器，而不是它现用的FAT32系统。这涉及到两个步骤：
- （可选的）创建一个新的分区布局。
- 在这个闪存上创建一个新的空的文件系统。

`fdisk`程序允许我们直接在底层与类似磁盘的设备（比如说硬盘驱动器和闪存驱动器）进行交互。使用这个工具可以在设备上编辑、删除、和创建分区。以我们的闪存驱动器为例，首先我们必须卸载它（如果需要的话），然后调用`fdisk`程序（创建分区布局的内容不再给出）：
```shell
[me@busybox ~]$ sudo umount /dev/sdb1
[me@busybox ~]$ sudo fdisk /dev/sdb      # 指定设备名称
```

然后通过`mkfs -t file-system-name device-name`在`device-name`这个设备上创建格式为`file-system-name`的文件系统。

（7）虽然操作系统以文件系统组织数据，但实际上数据是以“块”的形式组织。如果把磁盘驱动器简单地看成一个数据块大集合，我们就能执行有用的任务，如克隆设备。`dd if=input_file of=output_file [bs=block_size [count=blocks]]`可以把数据块从一个地方复制到另一个地方。

- e.g. 1：我们有两个相同容量的USB闪存驱动器，并且要精确地把第一个驱动器（中的内容）复制给第二个。如果连接两个设备到计算机上，它们各自被分配到设备`/dev/sdb`和`/dev/sdc`上，这样我们就能通过`dd if=/dev/sdb of=/dev/sdc`把第一个驱动器中的所有数据复制到第二个驱动器中。
- e.g. 2：如果只有第一个驱动器被连接到计算机上，我们可以通过`dd if=/dev/sdb of=flash_drive.img`把它的内容复制到一个普通文件中供以后恢复或复制数据。

（8）创建一个光盘只读存储器（CD-ROM）映像分两步走：
- 构建一个iso映像文件， 这就是一个CD-ROM的文件系统映像；
- 把这个映像文件写入到CD-ROM媒介中。

Linux下两个步骤都有相应的程序可以负责，此处不展开。

5、网络系统<br>
（1）用来监测网络和传输文件的常用命令：
- `ping` - 发送 ICMP ECHO_REQUEST 数据包到网络主机
- `traceroute` - 打印到一台网络主机的路由数据包
- `netstat` - 打印网络连接，路由表（`netstat -r`），接口统计数据，伪装连接，和多路广播成员。`macOS`还可使用`ifconfig`，意为interface config
- `ftp` - 因特网文件传输程序（通过`ftp ftp-server-name`登陆服务器，用`cd`在远端系统中进行目录跳转，用`get`告诉远端系统传送文件到本地，用`lcd`切换本地路径）
- `wget` - 非交互式网络下载器
- `ssh` - OpenSSH SSH 客户端（远程登录程序）

（2）早些年，在因特网普遍推广之前，有一些受欢迎的程序被用来登录运行这类Unix操作系统的远程主机。它们是 rlogin 和 telnet 程序。然而这些程序，拥有和 ftp 程序 一样的致命缺点；它们以明码形式来传输所有的交流信息（包括登录命令和密码）。

现在主要采用SSH（Secure Shell）。 SSH 解决了这两个基本的和远端主机安全交流的问题：
- 它要认证远端主机是否为它所知道的那台主机（这样就阻止了所谓的“中间人”的攻击）；
- 它加密了本地与远程主机之间 所有的通讯信息。

SSH 由两部分组成。SSH 服务端运行在远端主机上，在端口 22 上监听收到的外部连接，而 SSH 客户端用在本地系统中，用来和远端服务器通信。一些发行版默认包含客户端和服务端两个软件包（例如 Red Hat），而另一些（比方说 Ubuntu）则只提供客户端。 **为了能让系统接受远端的连接，它必须安装 OpenSSH-server 软件包，配置，运行它，并且（如果系统正在运行，或者系统在防火墙之后）它必须允许在 TCP 端口 22 上接收网络连接。**

ssh 验证远端主机的真实性。如果远端主机不能成功地通过验证，这可能是因为远端系统已经改变了。例如，它的操作系统或者是 SSH 服务器重新安装了。

SSH 协议允许大多数网络流量类型通过这条加密通道来被传送，在本地与远端系统之间创建一种 VPN（虚拟专用网络）。这个特性的最普遍的用法是允许传递 X 窗口系统流量。在运行着 X 服务端的系统（也就是，能显示 GUI 的机器）上，能登录远端系统并运行一个 X 客户端程序（一个图形化应用），而应用程序的显示结果出现在本地。假设我们正坐在一台名为 linuxbox 的 Linux 系统前，且系统中运行着 X 服务端，现在我们想要在名为 remote-sys 的远端系统中 运行 xload 程序，但是要在我们的本地系统中看到这个程序的图形化输出。我们可以这样做：
```shell
[me@linuxbox ~]$ ssh -X remote-sys
me@remote-sys's password:
Last login: Mon Sep 08 13:23:11 2008
[me@remote-sys ~]$ xload
```

通过`scp`和`sftp`利用 SSH 加密通道在网络间复制文件。

关于SSH的内容，macOS上可以Terminus软件，windows上则可以使用PuTTY。

### 查找、压缩和归档
6、文件查找

（1）查找文件相关的命令：
- `locate` – 通过名字来查找文件
- `find` – 在一个目录层次结构中搜索文件
- `xargs` – 从标准输入生成和执行命令行
- `touch` – 更改文件时间（通常被用来设置或更新文件的访问，更改，和修改时间。然而，如果一个文件名参数是一个 不存在的文件，则会创建一个空文件）
- `stat` – 显示文件或文件系统状态（加上`-x`可打印出易读的形式）

（2）`locate`在路径名数据库中查找包含给定字符串的路径：
```shell
(base) ➜  playground locate /bin/zip
/usr/bin/zip
/usr/bin/zipcloak
/usr/bin/zipdetails
/usr/bin/zipdetails5.18
/usr/bin/zipdetails5.28
/usr/bin/zipgrep
/usr/bin/zipinfo
/usr/bin/zipnote
/usr/bin/zipsplit
```

locate 数据库由另一个叫做`updatedb`的程序创建。通常，这个程序作为一个定时任务（jobs）周期性运转；也就是说，一个任务在特定的时间间隔内被 cron 守护进程执行。大多数装有 locate 的系统会每隔一天运行一回`updatedb`程序。因为数据库不能被持续地更新，所以当使用`locate`时，你会发现 目前最新的文件不会出现。为了克服这个问题，通过更改为超级用户身份，在提示符下手动运行`updatedb`命令。

（3）`locate`程序只能依据文件名来查找文件，而`find`程序能基于**各种各样的属性**搜索一个
**给定目录（以及它的子目录）**来查找文件。 `find`的`-type`参数限定搜索目标的类型。文件的类型前文讲过：

| 文件类型 | 描述
| --- | ---
| `b` | 块特殊设备文件
| `c` | 字符特殊设备文件
| `d` | 目录
| `f` | 普通文件
| `l` | 符号链接

【1】用`-size`指定对要搜索的文件大小的约束。文件大小的单位后选项有：`b`（512 bytes block）、`c`（byte）、`w`（word）、`k`、`M`、`G`等。命令`find ~ -type f -name "*.JPG" -size +1M | wc -l`中，`1M`前面有符号`+`，含义是文件大小要大于1M。`.JPG`要加上双引号，防止被展开。

【2】`find`支持的测试条件非常多，以下列出了部分内容：
| 测试条件 | 描述
| --- | ---
| `-cmin n` | 匹配内容或属性最后修改时间正好在 n 分钟之前的文件或目录。 指定少于 n 分钟之前，使用 -n，指定多于 n 分钟之前，使用 +n。
| `-cnewer file` | 匹配内容或属性最后修改时间晚于 file 的文件或目录。
| `-ctime n` | 匹配内容和属性最后修改时间在n*24小时之前的文件和目录。
| `-empty` | 匹配空文件和目录。
| `-group name` | 匹配属于一个组的文件或目录。组可以用组名或组 ID 来表示。
| `-iname pattern` | 就像-name 测试条件，但是不区分大小写。
| `-inum n` | 匹配 inode 号是n的文件。这对于找到某个特殊 inode 的所有硬链接很有帮助。
| `-mmin n` | 匹配内容被修改于 n 分钟之前的文件或目录。
| `-mtime n` | 匹配的文件或目录的内容被修改于n*24小时之前。
| `-name pattern` | 用指定的通配符模式匹配的文件和目录。
| `-newer file` | 匹配内容晚于指定的文件的文件和目录。**这在编写执行备份的 shell 脚本的时候很有帮。 每次你制作一个备份，更新文件（比如说日志），然后使用 find 命令来判断哪些文件自从上一次更新之后被更改了。**
| `-nouser` | 匹配不属于一个有效用户的文件和目录。这可以用来**查找属于被删除的帐户的文件或监测攻击行为**。
| `-nogroup` | 匹配不属于一个有效的组的文件和目录。
| `-perm mode` | 匹配权限已经设置为指定的 mode的文件或目录。mode 可以用 八进制或符号表示法。
| `-samefile name` | 类似于-inum 测试条件。匹配和文件 name 享有同样 inode 号的文件。
| `-size n` | 匹配大小为 n 的文件
| `-type c` | 匹配文件类型是 c 的文件。
| `-user name` | 匹配属于某个用户的文件或目录。这个用户可以通过用户名或用户 ID 来表示。

【3】`find`支持用操作符来描述测试条件之间的逻辑关系。
| 操作符 | 描述
| --- | ---
| `-and` | 如果操作符两边的测试条件都是真，则匹配。可以简写为`-a`。 若没有使用操作符，则默认使用`-and`（正因如此，测试条件的排序将对结果有影响！）
| `-or` | 若操作符两边的任一个测试条件为真，则匹配。可以简写为`-o`
| `-not` | 若操作符后面的测试条件是假，则匹配。可以简写为一个感叹号（`!`）
| `()` | 把测试条件和操作符组合起来形成更大的表达式。这用来控制逻辑计算的优先级。默认情况下，`find`命令按照从左到右的顺序计算。经常有必要重写默认的求值顺序，以得到期望的结果。 即使没有必要，有时候包括组合起来的字符，对提高命令的可读性是很有帮助的。注意，因为圆括号字符对于 shell 来说有特殊含义，所以在命令行中使用它们的时候，它们必须用引号引起来，才能作为实参传递给`find`命令。通常反斜杠字符被用来转义圆括号字符

【4】命令`find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)`查找对当前用户而言不具备读写权限的文件或目录。涉及逻辑运算的部分，`find`和C语言一样，**后面的逻辑表达式不总是执行**。

【5】一些预定义的命令操作：
| 操作 | 描述
| --- | ---
| `-delete` | 删除当前匹配的文件。
| `-ls` | 对匹配的文件执行等同的`ls -dils`命令。并将结果发送到标准输出。
| `-print` | 把匹配文件的全路径名输送到标准输出。如果没有指定其它操作，这是 默认操作。
| `-quit` | 一旦找到一个匹配，退出。

【6】除了预定义的命令，还可以通过`-exec command {} ;`调用我们传递进来的任意命令。这里的`command`就是指一个命令的名字，`{}`是当前路径名的符号表示，分号是必要的分隔符，表明命令的结束。若用`-ok`来代替`-exec`，则在执行每个指定的命令之前，会提示用户（交互式进行）。下面的案例中搜索以字符串“foo”开头的文件名，并且对每个匹配的文件执行`ls -l`命令：
```shell
find ~ -type f -name 'foo*' -exec ls -l '{}' ';'
```
当`-exec`行为被使用的时候，若每次找到一个匹配的文件，它会启动一个新的指定命令的实例。我们可能更愿意把所有的搜索结果结合起来，再运行一个命令的实例，从而提高运行效率。也就是说，将
```shell
ls -l file1
ls -l file2
...
```
变为
```shell
ls -l file1 file2 ...
```
如何达到这个目的？有两种方法。

- **方法一**：将`;`改为`+`，即`find ~ -type f -name 'foo*' -exec ls -l '{}' '+'`。
- **方法二**：使用`xargs`，即`find ~ -type f -name 'foo*' -print | xargs ls -l`。

7、压缩和归档<br>
（1）掌握常用的管理文件集合的程序：
- `gzip` – 压缩或者展开文件
- `tar` – 磁带打包工具
- `zip` – 打包和压缩文件
- `rsync` – 同步远端文件和目录

（2）数据压缩<br>
数据压缩就是一个删除冗余数据的过程。压缩算法（数学技巧被用来执行压缩任务）分为两大类，无损压缩和有损压缩。无损压缩保留了 原始文件的所有数据。这意味着，当还原一个压缩文件的时候，还原的文件与原文件一模一样。 而另一方面，有损压缩，执行压缩操作时会删除数据，允许更大的压缩。当一个有损文件被还原的时候， 它与原文件不相匹配; 相反，它是一个近似值。有损压缩的例子有 JPEG（图像）文件和 MP3（音频）文件。 

接下来主要关注无损压缩工具。

【1】使用`gzip filename`和`gunzip gz-filename`进行压缩和解压缩（用`gzip --help`）查看参数列表。下面的例子将某个目录列表作为压缩源并将压缩结果写入名为`foo.txt.gz`的文件：
```shell
ls -l /etc | gzip > foo.txt.gz
```
压缩后的`.gz`文件是二进制文件，通过`gunzip foo.txt.gz`进行解压缩。如果我们只想粗略地浏览下原始文件的内容，可以使用命令`gunzip -c foo.txt.gz | less`或`zless foo.txt.gz`，其中`-c`表示将解压缩的内容输出到stdout。此外，命令`zcat`等价于`gunzip -c`。

【2】和`gzip`几乎一致，`bzip2`也是一个压缩程序，主要区别在于使用了不同的压缩算法（牺牲压缩时间提升压缩级别）。`bzip2`具有和`gzip`几乎一致的使用选项。相应地，使用`bunzip2`和`bzcat`程序来解压缩文件。

【3】再次压缩已经压缩过的文件，可能会得到更大的文件。这是因为，如果一个文件已经不包含任何冗余信息，再次压缩只会添加关于此次压缩的信息。

（3）归档<br>
【1】归档就是收集许多文件，并把它们 捆绑成一个大文件的过程。归档经常作为系统备份的一部分来使用。当把旧数据从一个系统移到某种类型的长期存储设备中时，也会用到归档程序。

【2】在类 Unix 的软件世界中，`tar`程序是用来归档文件的经典工具。它曾是一款制作磁带备份的工具，现在仍然被用来完成传统任务，但适用于其它的存储设备。我们经常看到扩展名为`.tar`或者`.tgz`的文件，它们各自表示“普通” 的 tar 包和被`gzip`程序压缩过的 tar 包。一个 tar 包可以由**一组独立的文件，一个或者多个目录，或者两者混合体**组成。

【3】`tar`的（简单）语法如下：`tar mode[options] pathname ...`。这里`mode`前面加不加`-`都可以。部分常用的mode（模式）有：

模式 | 说明
--- | ---
`c` | 为文件和／或目录列表创建归档文件。
`x` | 抽取归档文件。
`r` |追加具体的路径到归档文件的末尾。
`t` | 列出归档文件的内容。
<br>

更为具体的使用方法如下：
```shell
(base) ➜  playground tar --help
tar(bsdtar): manipulate archive files
First option must be a mode specifier:
  -c Create  -r Add/Replace  -t List  -u Update  -x Extract
Common Options:
  -b #  Use # 512-byte records per I/O block
  -f <filename>  Location of archive
  -v    Verbose
  -w    Interactive
Create: tar -c [options] [<file> | <dir> | @<archive> | -C <dir> ]
  <file>, <dir>  add these items to archive
  -z, -j, -J, --lzma  Compress archive with gzip/bzip2/xz/lzma
  --format {ustar|pax|cpio|shar}  Select archive format
  --exclude <pattern>  Skip files that match pattern
  -C <dir>  Change to <dir> before processing remaining files
  @<archive>  Add entries from <archive> to output
List: tar -t [options] [<patterns>]
  <patterns>  If specified, list only entries that match
Extract: tar -x [options] [<patterns>]
  <patterns>  If specified, extract only entries that match
  -k    Keep (don't overwrite) existing files
  -m    Don't restore modification times
  -O    Write entries to stdout, don't restore to disk
  -p    Restore permissions (including ACLs, owner, file flags)
bsdtar 3.3.2 - libarchive 3.3.2 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.6
```

**`tar`的使用案例：**<br>
- `tar cf playground.tar playground`：创建了一个名为`playground.tar`的 tar 包，其包含整个 playground 目录层次结果。
- `tar tf playground.tar`：列出归档文件`playground.tar`的内容。
- `tar xf ../playground.tar`：抽取/安装归档文件`playground.tar`的内容到新目录（相对路径暗示了`playground.tar`和新目录之间的位置关系），即创建了一个精确的原始文件的副本。

默认情况下，待归档的文件/目录名是相对的，但是如果我们以绝对路径来指定待归档的文件/目录名，那么它们也会被以绝对路径的方式被归档。下面给出了一个例子：
```shell
(base) ➜  playground ls -l
total 0
drwxr-xr-x@   2 hliangzhao  staff    64 Jan 28 10:51 bar
drwxr-xr-x@ 102 hliangzhao  staff  3264 Jan 28 10:34 foo     # 待归档的目录
(base) ➜  playground pwd
/Users/hliangzhao/Documents/Codes/playground
(base) ➜  playground tar cf foo.tar /Users/hliangzhao/Documents/Codes/playground/foo
tar: Removing leading '/' from member names
(base) ➜  playground cd bar; tar xf ../foo.tar
(base) ➜  bar tree -L 6    # 抽取后发现是以绝对路径的方式被归档的
.
└── Users
    └── hliangzhao
        └── Documents
            └── Codes
                └── playground
                    └── foo

6 directories, 0 files
```
**这种方式很有用，因为这样就允许我们抽取文件到任意位置，而不是强制地把抽取的文件放置到原始目录下。**
例如以下这个文件迁移的案例：通过移动硬盘或者`ssh`将一个OS中的`home`的内容归档后到另一个目录的根目录下抽取，内容就被全部还原了。

结合`find`命令，从给定目录中搜索特定的文件和目录用于归档。一些示例：
- `find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'`：使用`find`命令来匹配`playground`目录中所有名为`file-A`的文件，然后使用`-exec`行为来唤醒带有追加模式（r）的tar命令，把匹配的文件添加到归档文件`playground.tar`里面。典型使用场景：使用`tar`和`find`命令，来创建逐渐增加的目录树或者整个系统的备份，是个不错的方法。通过`find`命令匹配新于某个时间戳的文件，我们就能够创建一个归档文件，其只包含新于上一个`tar`包的文件，假定这个时间戳文件恰好在每个归档文件创建之后被更新了。
- `find playground -name 'file-A' | tar cf - --files-from=- | gzip > playground.tgz`：使用`find`程序产生了一个匹配文件列表，然后把它们管道到`tar`命令中。 如果指定了文件名`-`，则其被看作是**标准输入或输出**，正是所需（使用“-”来表示标准输入／输出的惯例，也被大量的其它程序使用）。这个`--file-from`选项（也可以用`-T`来指定）导致`tar`命令从一个文件而不是命令行来读入它的路径名列表。最后，这个由`tar`命令产生的归档文件被管道到`gzip`命令中，然后创建了压缩归档文件`playground.tgz`。此`.tgz`扩展名是命名由`gzip`压缩的`tar`文件的常规扩展名。有时候也会使用`.tar.gz`这个扩展名。

上方这个例子，使用管道将归档文件送入`gzip`进行压缩。实际上可以直接在归档的时候指定`z`或者`j`选项进行直接压缩：`find playground -name 'file-A' | tar czf playground.tgz -T -`。`z`对应于`gzip`，`j`对应于`bzip2`。

【4】使用`zip`对文件和目录进行打包并压缩（通过`zip --help`查询命令格式）。常用命令：
- `zip -r playground.zip playground`：递归地将目录`playground`及其内容进行压缩并将结果写入`playground.zip`文件。压缩时会有一系列输出，例如“store”没有压缩的文件，或者“deflate”文件（即执行压缩操作）。一个文件没有被压缩大概率是因为它本身是空文件，没有可以被压缩的地方。
- `unzip zip-filer-path`：解压缩文件`zip-filer-path`到当前目录。
- `find playground -name "file-A" | zip -@ file-A.zip`：使用`-@`从管道中读取要打包并压缩的文件。`zip`命令支持把它的输出写入到标准输出，但是`unzip`不支持不接受标准输入。
- `ls -l /etc/ | zip ls-etc.zip -`：使用`-`从标准输入中读取要打包并压缩的文件。

对于`zip`命令（与`tar`命令相反）要注意一点，就是如果指定了一个已经存在的文件包，其被更新而不是被替代。这意味着会保留此文件包，但是会添加新文件，同时替换匹配的文件。

【5】`zip`和`unzip`命令的主要用途是为了和 Windows 系统交换文件，而不是在 Linux 系统中执行压缩和打包操作，`tar`和`gzip`程序在 Linux 系统中更受欢迎。

【6】使用`rsync`做文件备份。常用的（简化的）命令结构如下：`rsync options src dst`，其中`src`和`dst`是下列选项之一：
- 一个本地文件或目录
- 一个远端文件或目录，以`[user@]host:path`的形式存在
- 一个远端 rsync 服务器，由`rsync://[user@]host[:port]/path`指定
注意，至少要有一个是本地文件或目录。`rsync`通过检查`src`和`dst`的差异来做增量式更新。

**典型应用场景**：在外部硬盘上做文件备份：
```shell
sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup
```
其中`/media/BigDisk`是外部硬盘的挂载位置，`/etc`，`/home`和`/usr/local`是待同步的目录，`-–delete`这个选项，来删除可能在备份设备中已经存在但却不再存在于源设备中的文件。这是一个不错的（虽然不理想）方式来保存少量的系统备份文件的方法。

**使用`rsync`同步本地目录和可通过`ssh`连接的远程主机的目录**：
```shell
sudo rsync -av --delete --rsh=ssh /etc /home /usr/local remote-sys:/backup
```
`rsync`可以被用来在网络间同步文件的第二种方式是通过使用 rsync 服务器。`rsync`可以被配置为一个守护进程，监听即将到来的同步请求。
```shell
rsync -av -delete rsync://rsync.gtlib.gatech.edu/fedora-linux-core/development/i386/os fedora-devel
```
上面的命令将某个 rsync 服务器维护的linux操作系统镜像不同到本地某目录下。

### 正则表达式
8、正则表达式是一种符号表示法，被用来识别文本模式。在某种程度上，它们与匹配文件和路径名的 shell 通配符比较相似，但其规模更庞大。许多命令行工具和大多数的编程语言都支持正则表达式，以此来帮助解决文本操作问题。然而，并不是所有的正则表达式都是一样的，这就进一步混淆了事情；不同工具以及不同语言之间的正则表达式都略有差异。我们将会限定 POSIX 标准中描述的正则表达式（其包括了大多数的命令行工具）。

9、和正则表达式打交道的程序是`grep`（global regular expression print），本质上，`grep`程序会在其输入中查找一个指定的正则表达式，并输出匹配行。

（1）`grep`的一般使用形式是：`grep [options] regex [file ...]`。
常用的options有：
选项 | 描述
--- | ---
`-i` | 忽略大小写。不会区分大小写字符。也可用`--ignore-case`来指定。
`-v` | 不匹配。通常，`grep`程序会打印包含匹配项的文本行。这个选项导致`grep`程序只会打印不包含匹配项的文本行。也可用`--invert-match`来指定。
`-c` | 打印匹配的数量（或者是不匹配的数目，若指定了`-v`选项），而不是文本行本身。 也可用`--count`选项来指定。
`-l` | 打印包含匹配项的文件名，而不是文本行本身，也可用`--files-with-matches`选项来指定。
`-L` | 相似于`-l`选项，但是只是打印不包含匹配项的文件名。也可用`--files-without-match`来指定。
`-n` | 在每个匹配行之前打印出其位于文件中的相应行号。也可用`--line-number`选项来指定。
`-h` | 应用于多文件搜索，不输出文件名。也可用`--no-filename`选项来指定。

之前给出的例子`regex`基本上是直接根据**原义字符**给出的正则表达式，如`grep bzip some-file-path`等。

（2）正则表达式除了包含原义字符，还包含元字符，其被用来指定更复杂的匹配项。元字符由以下字符组成：
```
^ $ . [ ] { } - ? * + ( ) | \
```
当在`regex`中使用元字符时，需要用引号以防止被shell展开。下面给出了一个简单的示例：
```shell
(base) ➜  playground grep -h '.zip' dirlist*
bunzip2
bzip2
bzip2recover
```
其中`.`匹配任意字符（可理解为占位）。

（3）使用锚点：在正则表达式中，插入符号和美元符号被看作是锚点。这意味着正则表达式只有在文本行的**开头**或**末尾**被找到时，才算发生一次匹配。示例：
- `grep '^zip' dirlist*`（以`zip`开头的任意文本行）
- `grep 'zip$' dirlist*`（以`zip`结尾的任意文本行）
- `grep '^..j.r$' /usr/share/dict/words`（在字典里查找长度为5、第三个字符为`j`、最后一个字符为`r`的单词）

（4）使用中括号表达式从一个指定的字符集合中匹配**单个**字符。示例：
```shell
(base) ➜  playground grep '[bg]zip' dirlist-*
dirlist-usr-bin.txt:bzip2
dirlist-usr-bin.txt:bzip2recover
dirlist-usr-bin.txt:gzip
```
注意，元字符被放置到中括号里面后会失去了它们的特殊含义，除了以下两个：
- 插入字符`^`：用来表示否定；
- 连字符`-`：用来表示一个字符范围。
```shell
(base) ➜  playground grep '[^bg]zip' dirlist-*
dirlist-usr-bin.txt:bunzip2
dirlist-usr-bin.txt:funzip
dirlist-usr-bin.txt:gunzip
dirlist-usr-bin.txt:unzip
dirlist-usr-bin.txt:unzipsfx
(base) ➜  playground grep '[b-g]zip' dirlist-*
dirlist-usr-bin.txt:bzip2
dirlist-usr-bin.txt:bzip2recover
dirlist-usr-bin.txt:gzip
```
`grep -h '^[A-Za-z0-9]' dirlist*.txt`匹配所有以字母或数字开头的文本行，`grep -h '[-AZ]' dirlist-*`则匹配包含`-`或`A`或`Z`的文本行。

（5）以上给出了用`[]`和`-`所表示的、传统的字符区域的表示方法。更好的方法是使用POSIX字符集。我们已在[《学习shell》](https://github.com/hliangzhao/learn-ctl/blob/main/01-learn-shell.md)关于“字符展开”的章节谈到过它的使用，它同样可用于正则表达式。下面给出的是用于字符展开的例子：
```shell
(base) ➜  playground ls /usr/sbin/[[:upper:]]*
/usr/sbin/AppleFileServer       /usr/sbin/DirectoryService      /usr/sbin/WirelessRadioManagerd
/usr/sbin/BootCacheControl      /usr/sbin/KernelEventAgent
/usr/sbin/DevToolsSecurity      /usr/sbin/PasswordService
```
所谓的POSIX即portable os interface，是unix世界“巴尔干化”后由IEEE组织并制定的一套通用标准（IEEE 1003），覆盖了应用程序编程接口（APIs），shell和一些实用程序等内容。

常用的POSIX字符集如下：
字符集 | 说明
--- | ---
`[:alnum:]` | 字母数字字符。在 ASCII 中，等价于：`A-Za-z0-9`
`[:word:]` | 与`[:alnum:]`相同, 但增加了下划线字符。
`[:alpha:]` | 字母字符。在 ASCII 中，等价于：`A-Za-z`
`[:blank:]` | 包含空格和 tab 字符。
`[:cntrl:]` | ASCII 的控制码。包含了0到31，和127的 ASCII 字符。
`[:digit:]` | 数字0到9
`[:graph:]` | 可视字符。在 ASCII 中，它包含33到126的字符。
`[:lower:]` | 小写字母。
`[:punct:]` | 标点符号字符。在 ASCII 中，等价`-!"#$%&'()*+,./:;<=>?@[\\\]_`{|}~`
`[:print:]` | 可打印的字符。在[:graph:]中的所有字符，再加上空格字符。
`[:space:]` | 空白字符，包括空格、tab、回车、换行、vertical tab 和 form feed。在 ASCII 中， 等价于：` \t\r\n\v\f`
`[:upper:]` | 大写字母。
`[:xdigit:]` | 用来表示十六进制数字的字符。在 ASCII 中，等价于`0-9A-Fa-f`
<br>

使用POSIX字符集的时候，要在外面在包含一层`[]`，否则仍旧被按照普通的字符区域处理。

（6）POSIX把正则表达式的实现分成了两类：基本正则表达式（BRE）和扩展的正则表达式（ERE）。后者比前者（仅包含`^ $ . [ ] *`）拥有更多的元字符，并且用反斜杠转义后成为原义字符（前者与之正好相反）。`egrep`和`grep -e`均可处理ERE。接下来给出ERE的常用匹配策略。

【1】交替：`|`<br>
```shell
(base) ➜  playground echo "ABC" | grep -E 'AAA|B|CC'
ABC
```
上面的例子中，将字符串`ABC`通过管道作为`grep`带匹配的目标，模式则是`ABC`或`B`或`CC`中间的任意一个。
模式需带上引号以防止被shell理解为管道（展开）。

用元字符`()`将模式视为一个整体（可理解为优先级调整）。下面有个例子：
- `grep -Eh '^(bz|gz|zip)' dirlist*.txt`：匹配以`bz`或`gz`或`zip`开头的文本行；
- `grep -Eh '^bz|gz|zip' dirlist*.txt`：匹配以`bz`开头或包含`gz`，或包含`zip`的文本行。



【2】限定符`?`：匹配零个或1个元素。即位于`?`前面的字符可有可无。
```shell
(base) ➜  playground echo "(025) 8888-2010" | grep -E '^\(?[[:digit:]][[:digit:]][[:digit:]]\)?'
(025) 8888-2010       # 匹配(025)
(base) ➜  playground echo "025 8888-2010" | grep -E '^\(?[[:digit:]][[:digit:]][[:digit:]]\)?'
025 8888-2010         # 匹配025
```
在ERE中，`(`和`)`是元字符，因此需要使用`\`转义为原义字符。**注意区分正则表达式中的`?`和通配符匹配中的`?`。前者中，`?`前的字符零个或1个；后者中，`?`所占的位置有一个字符**。

【3】限定符`*`：匹配零个或多个元素。下面这个例子`[[:upper:]][[:upper:][:lower:] ]*.`匹配一个如下的字符串：“开始于一个大写字母，然后包含任意多个大写和小写的字母和空格，最后以句号收尾”。（分析：`*`指定的仍然是前面的一个字符的个数。这个例子可被理解为`[chars]*`，而`[chars]`代表的正式单个「来自`chars`的」字符）

【4】限定符`+`：匹配一个或多个元素。下面这个例子`^([[:alpha:]]+ ?)+$`匹配一个由“一个或多个字母字符”组构成的字符串，且要求字母字符之间由单个空格分开。（分析：`[[:alpha:]]+`和上文的`[chars]*`一样，单个字符出现至少一次。` ?`则要求` `至多出现1次。那么，如何表达`[[:alpha:]] ?`组成的模式整体至少出现一次呢？不能用`[]`，因为这匹配`[[:alpha:]] ?`中的单个字符，因此顺理成章地用`()`。）


**同样地，注意区分正则表达式中的`*`和通配符匹配中的`*`。**

【5】`{}`：匹配指定数目的、位于`{}`前面的字符。
限定符 | 意思
--- | ---
`{n}` | 匹配前面的元素，如果它确切地出现了 n 次。
`{n,m}` | 匹配前面的元素，如果它至少出现了n 次，但是不多于 m 次。
`{n,}` | 匹配前面的元素，如果它至少出现了n 次。
`{,m}` | 匹配前面的元素，如果它出现的次数不多于 m 次。

使用`{}`可以简化模式。例如`echo "(555) 123-4567" | grep -E '^\(?[0-9]{3}\)? [0-9]{3}-[0-9]{4}$`可以让我们不至于将`[0-9]`抄写11遍。

【6】`find`命令支持基于正则表达式的测试。命令`find . -regex '.*[^-\_./0-9a-zA-Z].*'`会在当前目录及其子目录中发现包含空格和其它潜在不规范字符的路径名。

【7】一个常用的技巧：`less`和`vim`两者享有相同的文本查找方法——**按下`/`按键，然后输入正则表达式，来执行搜索任务。**

### 文本处理
10、下面处理文本常用的工具，需要熟练并灵活使用它们：
- `cat` – 连接文件并且打印到标准输出
- `sort` – 给文本行排序
- `uniq` – 报告或者省略重复行
- `cut` – 从每行中删除文本区域
- `paste` – 合并文件文本行
- `join` – 基于某个共享字段来联合两个文件的文本行
- `comm` – 逐行比较两个有序的文件
- `diff` – 逐行比较文件
- `patch` – 给原始文件打补丁
- `tr` – 翻译或删除字符（translate）
- `sed` – 用于筛选和转换文本的流编辑器（stream editor）
- `aspell` – 交互式拼写检查器（interactive spell checker）

11、编写文档时，一个流行的方法是先用文本格式来编写一个大的文档，然后**使用一种标记语言来描述已完成文档的格式**。网页、科学论文（TeX）、程序的源代码等都是用这种方法编写的。以网页为例，它们是文本文档，使用HTML（超文本标记语言）或者是XML（可扩展的标记语言）作为标记语言来描述文档的可视格式。此外，email 也是一个基于文本的媒介。为了传输，甚至非文本的附件也被转换成文本表示形式。 

**在类 Unix 的系统中，输出会以纯文本格式发送到打印机，或者如果页面包含图形，其会被转换成一种文本格式的页面描述语言，以 PostScript 著称，然后再被发送给一款能产生图形点阵的程序，最后被打印出来。**
需要注意的是，MS-DOS 和它的衍生品使用回车（ASCII 13）和换行字符序列来终止每个文本行，而 Unix 通过一个换行符（ASCII 10）来结束一行。

在类 Unix 系统中会发现许多命令行程序被用来支持系统管理和软件开发，并且文本处理程序也不例外。许多文本处理程序被设计用来解决软件开发问题。文本处理对于软件开发者而言至关重要，这是因为所有的软件都起始于文本格式。源代码，也就是程序员实际编写的一部分，总是文本格式。

12、`cat`：链接内容并输出到标准输出。

（1）带上`-e`选项来显示non-printing characters：
```shell
(base) ➜  playground cat -e foo.txt
	The quick brown fox jumped over the lazy dog.$
```
上面的例子中，第一个符号是制表符（Tab键或Ctrl-I），最后的字符`$`表示这是本行末尾。

（2）带上`-n`给文本添加行号，带上`-s`禁止输出多个空行。更多选项查询`man cat`。

13、`sort`：对标准输入的内容或命令行中指定的一个或多个文件按照行的内容进行排序，然后把排序结果发送到标准输出。
`sort`程序能接受命令行中的多个文件作为参数，此时是对这些文件的所有行排序并输出，使用管道可以讲排序结果写入一个新文件中，如`sort file1.txt file2.txt file3.txt > final_sorted_list.txt`。

（1）`sort`常用的选项：
选项 | 长选项 | 描述
--- | --- | ---
`-b` | `--ignore-leading-blanks` | 默认情况下，对整行进行排序，从每行的第一个字符开始。这个选项使`sort`程序忽略每行开头的空格，从第一个非空白字符开始排序。
`-f` | `--ignore-case` | 让排序不区分大小写。
`-n` | `--numeric-sort` | 基于字符串的数值来排序。使用此选项允许根据数字值执行排序，而不是字母值（要求数字出现在每行开头）。
`-r` | `--reverse` | 按相反顺序排序。结果按照降序排列，而不是升序。
`-k` | `--key=field1[,field2]` | 对从field1到field2之间的字符排序，而不是整个文本行。
`-m` | `--merge` | 把每个参数看作是一个预先排好序的文件。把多个文件合并成一个排好序的文件，而没有执行额外的排序。
`-o` | `--output=file` | 把排好序的输出结果发送到文件，而不是标准输出。
`-t` | `--field-separator=char` | 定义域分隔字符。默认情况下，域由空格或制表符分隔。

（2）排序某目录对硬盘空间的占用：
```shell
(base) ➜  playground du -s /usr/share/* | sort -nr | head
130720	/usr/share/tokenizer
72464	/usr/share/man
33568	/usr/share/vim
26272	/usr/share/icu
25656	/usr/share/langid
12880	/usr/share/zsh
12496	/usr/share/terminfo
11392	/usr/share/doc
11112	/usr/share/firmware
9032	/usr/share/cups
(base) ➜  playground du -sh /usr/share/* | sort -nr | head
768K	/usr/share/cracklib
340K	/usr/share/sandbox
316K	/usr/share/screen
284K	/usr/share/calendar
220K	/usr/share/kpep
216K	/usr/share/examples
140K	/usr/share/pmenergy
 84K	/usr/share/misc
 64M	/usr/share/tokenizer
 36K	/usr/share/CoreDuetDaemonConfig.bundle
```
上例中，使用`du`显示目录`/usr/share/`下的内容占用的容量。因为数字出现在开头，因此`sort`带上`-n`用行首的数字大小排序。当`du`带上`-h`选项时，用human-readable的方式显示空间占用。因为单位（`K`、`M`等）不会被放进来排序，所以两次排序的结果是不一样的（当一个字符不再是数字时，排序用的数字读取到此为止）。

（3）`-k`的使用：<br>
**示例一：**
照第五个字段的数字大小（文件大小）做为排序的依据。其中，空白字符（空格和制表符）被当作是字段间的界定符。
```shell
(base) ➜  playground ls -l /usr/bin | sort -nr -k 5 | head
-rwxr-xr-x   1 root   wheel  14132944 Sep 22 08:30 php
-rwxr-xr-x   1 root   wheel   5665520 Sep 22 08:29 fileproviderctl
```

**示例二：**
指定多个排序关键值。一个关键值可能包括一个字段区域。如果没有指定区域（如同之前的例子），`sort`程序会使用一个键值，其始于指定的字段，一直扩展到行尾。
```shell
(base) ➜  playground sort --key=1,1 --key=2n distros.txt
Fedora          5.1    03/20/2006
Fedora          6      10/24/2006
Fedora          7      05/31/2007
Fedora          8      11/08/2007
Fedora          8      11/08/2007
Fedora          10     11/25/2008
SUSE            10.2   12/07/2006
SUSE            10.3   10/04/2007
SUSE            11.04  06/19/2008
Ubuntu          8.04   04/24/2008
```
第一个排序关键值是`--key=1,1`，表明始于并且结束于第一个字段；第二个排序关键值是**第二个字段的数值**。后一轮排序是在前一轮排序的基础之上进行的。

上个示例中，如何按照日期的早晚进行排序？注意此处的日期是美式记法。`sort`程序提供了一种方式：`key`选项允许在字段中指定偏移量，所以我们能在字段中定义键值。下面给出了使用方法。
```shell
(base) ➜  playground sort -k 3.7nbr -k 3.1nbr -k 3.4nbr distros.txt
Fedora          10     11/25/2008
SUSE            11.04  06/19/2008
Ubuntu          8.04   04/24/2008
Fedora          8      11/08/2007
Fedora          8      11/08/2007
SUSE            10.3   10/04/2007
Fedora          7      05/31/2007
SUSE            10.2   12/07/2006
Fedora          6      10/24/2006
Fedora          5.1    03/20/2006
```
通过指定`-k 3.7`，我们指示`sort`程序使用一个排序键值，其**始于第三个字段中的第七个字符**（遇到非数字字符自动截止），对应于年的开头。同样地，我们指定`-k 3.1`和`-k 3.4`来分离日期中的月和日。我们也添加了`n`和`r`选项来实现一个逆向的数值排序。这个`b`选项用来删除日期字段中开头的空格（行与行之间的空格数迥异，因此会影响`sort`程序的输出结果）。

（4）`sort`默认使用空格和制表符界定字段。使用`-t`可以手动指定分隔符。例如`sort -t ':' -k 7 /etc/passwd`。

14、`uniq`：当给定一个**排好序的**文件（包括标准输出），`uniq`会删除任意重复行，并且把结果发送到标准输出。 它常常和`sort`程序一块使用，来清理重复的输出。尽管如此，但`sort`程序本身支持一个`-u`选项，其可以从排好序的输出结果中删除重复行。

`uniq`的典型使用场景是报告重复行的个数（带上`-c`选项），如：
```shell
[me@linuxbox ~]$ sort foo.txt | uniq -c
        2 a
        2 b
        2 c
```

15、`cut`：从文本行中抽取文本，并把其输出到标准输出。它能够接受多个文件参数或者标准输入。`cut提供了如下选项用于指定待抽取的文本：
选项 | 说明
--- | ---
`-c char_list` | 从文本行中抽取由`char_list`定义的文本。这个列表可能由一个或多个逗号分隔开的数值区间组成。
`-f field_list` | 从文本行中抽取一个或多个由`field_list`定义的字段。这个列表可能包括一个或多个字段，或由逗号分隔开的字段区间。
`-d delim_char` | 当指定`f`选项之后，使用`delim_char`做为字段分隔符。**默认情况下，字段之间必须由单个 tab 字符分隔开。**
`--complement` | 抽取整个文本行，除了那些由`-c`和`／`或`-f`选项指定的文本。

下面的例子给出了`-f`和`-c`的使用示例。
```shell
(base) ➜  playground cat distros.txt          # 每个字段用过tab分隔
SUSE	10.2	12/07/2006
Fedora	10	11/25/2008
Ubuntu	6.10	10/26/2008
(base) ➜  playground cut -f 3 distros.txt     # 抽取第三个字段
12/07/2006
11/25/2008
10/26/2008
(base) ➜  playground cut -f 3 distros.txt | cut -c 7-10
2006
2008
2008
```
因为用tab分隔时，每行文字长度很难一致，因此`-c`并不实用。但是，可以借助`expand`将tab展开为空格，这样每行对应字段的内容就可以对齐。这时候再采用`-c`即可。下面给出了一个例子：
```shell
(base) ➜  playground expand distros.txt | cut -c 23-
2006
2008
2008
```
（对应地，还有`unexpand`将空格替换回tab）

16、`paste`：读取多个文件（或标准输入），然后把每个文件中的字段整合成单个文本流，输入到标准输出。
```shell
(base) ➜  playground cat distros-dates.txt
11/25/2008
10/26/2008
12/07/2006
(base) ➜  playground cat distros-versions.txt
Fedora	10
Ubuntu	6.10
SUSE	10.2
(base) ➜  playground paste distros-dates.txt distros-versions.txt
11/25/2008	Fedora	10
10/26/2008	Ubuntu	6.10
12/07/2006	SUSE	10.2
```

17、`join`：把来自于多个基于**共享关键域**的文件的数据结合起来（类似于关系型数据库中的join操作）。

18、比较文本<br>
（1）`comm`：这是一个很简单的命令，其格式为`comm [-123i] file1 file2`，接受且仅接受两个文件名作为输入，输出中的第一列表示`file1`特有的文本行，第二列表示`file2`特有的文本行，第三行则是二者共有的文本行。带上`-n`则隐藏第n列的内容。

（2）`diff`：比`comm`复杂，支持许多输出格式，并且一次能处理许多文本文件。软件开发员经常使用`diff`程序来检查不同程序源码版本之间的更改，`diff`能够递归地检查源码目录，经常称之为源码树。**`diff`程序的一个常见用例是创建`diff`文件或者补丁，它会被其它程序使用，例如`patch`程序，来把文件从一个版本转换为另一个版本。**

通常带上`-c`选项给出文件的比较结果。
```shell
(base) ➜  playground cat file1.txt
a
b
c
d
(base) ➜  playground cat file2.txt
b
c
d
e
(base) ➜  playground diff file1.txt file2.txt
1d0   # 删除第一个文件中位置1处的文本行，这些文本行将会出现在第二个文件中位置0处
< a
4a4   # 把第二个文件中位置4处的文件行添加到第一个文件中的4处
> e 
(base) ➜  playground diff -c file1.txt file2.txt
*** file1.txt	Thu Jan 28 22:42:47 2021
--- file2.txt	Thu Jan 28 22:43:08 2021
***************
*** 1,4 ****
- a
  b
  c
  d
--- 1,4 ----
  b
  c
  d
+ e
```

19、使用`patch`将更改应用到文本文件中：它接受从`diff`程序的输出，并且通常被用来把较老的文件版本转变为较新的文件版本。以对linux内核代码的贡献为例，每个修改者只需提交一个包含了先前的内核版本与带有贡献者修改的新版本之间的差异的diff文件，接收者再使用`patch`将这些更改应用到他自己的源码树中即可。

通过`diff -Naur file1.txt file2.txt > patchfile.txt`紧接着`patch < patchfile.txt`将补丁应用到`file1.txt`上。

20、运行时编辑<br>
（1）`tr`：操作标准输入，并把结果输出到标准输出。是一种基于字符的查找和替换。`tr`命令接受两个参数：要被转换的**字符集**以及相对应的转换后的字符集。字符集的表达方式：
- 一个枚举列表。例如，`ABCDEFGHIJKLMNOPQRSTUVWXYZ`；
- 一个字符域。例如，`A-Z`。注意这种方法有时候面临与其它命令相同的问题，归因于语系的排序规则，因此应该谨慎使用；
- `POSIX`字符类。例如，[:upper:]。**此时须加上引号（macOS）**。

一些典型用法：
```shell
(base) ➜  playground echo "lowercase letters" | tr a-z A-Z   # 枚举列表的方式
LOWERCASE LETTERS
(base) ➜  playground echo "secret text" | tr a-zA-Z n-za-mN-ZA-M    # ROT13文本编码（每个字符向前移动13位）
frperg grkg
(base) ➜  playground echo "frperg grkg" | tr a-zA-Z n-za-mN-ZA-M
secret text
(base) ➜  playground echo "lowercase letters" | tr "[:lower:]" A   # 字符类
AAAAAAAAA AAAAAAA
(base) ➜  playground echo "lowercase letters" | tr '[:lower:]' A
AAAAAAAAA AAAAAAA
(base) ➜  playground echo "aaabbbccc" | tr -s ab     # 删除重复的、枚举列表中的字符a和b
abccc
```

（2）`sed`：对一系列指定的文件或标准输入进行复杂的编辑。查阅`man sed`了解其使用细节。

21、格式化输出

下面列举的是格式化输出文本的程序，它们并不改变文本内容本身。
- `nl` – 添加行号（number lines），结合`sed`使用，可生成某文档的包含页眉、主体（加行号）和页脚的漂亮报告。
- `fold` – 限制文件列宽
- `fmt` – 一个简单的文本格式转换器
- `pr` – 让文本为打印做好准备
- `printf` – 格式化数据并打印出来
- `groff` – 一个文件格式化系统

（1）`fold`：用`-w num`限定行宽为`num`（默认值为80）。增加`-s`选项保留单词边界。
```shell
(base) ➜  playground echo "The quick brown fox jumped over the lazy dog." | fold -w 12
The quick br
own fox jump
ed over the
lazy dog.
(base) ➜  playground echo "The quick brown fox jumped over the lazy dog." | fold -w 12 -s
The quick
brown fox
jumped over
the lazy
dog.
```

（2）`fmt`：同`fold`一样，也是折叠文本，但外加了很多功能。它接受文本或标准输入并且在文本流上格式化段落。它主要是填充和连接文本行，同时保留空白符和缩进。
- `-w width`指定行宽；
- `-p 'char '`格式化文件中以字符`char`开头的部分（如注释符`#`），注意`char`后需跟上一个空格。

使用方式形如`fmt -w 50 -p '# ' filename`。

（3）`pr`：用来把文本分页。当打印文本的时候，经常希望用几个空行在输出的页面的顶部或底部添加空白。此外，这些空行能够用来插入到每个页面的页眉或页脚。
```shell
(base) ➜  playground pr -l 15 -w 65 distros.txt
... blank lines ...
Jan 30 11:04 2021 distros.txt Page 1
... blank lines ...
SUSE        10.2     12/07/2006
Fedora      10       11/25/2008
... blank lines ...
Jan 30 11:04 2021 distros.txt Page 2
... blank lines ...
SUSE        10.3     10/04/2007
Ubuntu      6.10     10/26/2006
... blank lines ...
```
在上面的例子中，我们用`-l`选项（页长）和`-w`选项（页宽）定义了宽65列，长15行的一个“页面”。`pr`为distros.txt中的内容编订页码，用空行分开各页面，生成了包含文件修改时间、文件名、页码的默认页眉。

（4）`printf`：和C语言中的`printf`几乎一致。

【1】基本的格式化符的使用：下面的例子中字符串`abc`是否加引号无所谓。
```shell
(base) ➜  playground printf "%d, %f, %o, %s, %x, %X, %s\n" 380 380 380 380 380 380 "abc"
380, 380.000000, 574, 380, 17c, 17C, abc
```

【2】完整的转换规范：`%[flags][width][.precision]conversion_specification`
组件 | 描述
--- | ---
`flags` | 有5种不同的标志: <ui><li>`#`：使用“备用格式”输出。这取决于数据类型。对于`o`（八进制数）转换，输出以`0`为前缀。对于`x`和`X`（十六进制数）转换，输出分别以`0x`或`0X`为前缀。</li><li>`0`：用零填充输出。这意味着该字段将填充前导零，比如“000380”。</li><li>`-`：左对齐输出。默认情况下，printf右对齐输出。</li><li>‘ ’（空格）：在正数前空一格。</li><li>`+`：在正数前添加加号。默认情况下，printf 只在负数前添加符号。</li></ui>
`width` | 指定最小字段宽度的数。
`.precision` | 对于浮点数，指定小数点后的精度位数。对于字符串转换，指定要输出的字符数。

一些示例：
自变量 | 格式 | 结果 | 备注
--- | --- | --- | ---
380 | "%d" | 380 | 简单格式化整数。
380 | "%#x" | 0x17c | 使用“替代格式”标志将整数格式化为十六进制数。
380 | "%05d" | 00380 | 用前导零（padding）格式化整数，且最小字段宽度为五个字符。
380 | "%05.5f" | 380.00000 | 使用前导零和五位小数位精度格式化数字为浮点数。由于指定的最小字段宽度（5）小于格式化后数字的实际宽度，因此前导零这一命令实际上没有起到作用。
380 | "%010.5f" | 0380.00000 | 将最小字段宽度增加到10，前导零现在变得可见。
380 | "%+d" | +380 | 使用+标志标记正数。
380 | "%-d" | 380 | 使用-标志左对齐
abcdefghijk | "%5s" | abcedfghijk | 用最小字段宽度格式化字符串。
abcdefghijk | "%.5s" | abcde | 对字符串应用精度，它被从中截断。

需要注意的是，指定宽度的命令会对文本的布局产生影响：
```shell
(base) ➜  playground printf "Line: %05d %15.3f Result: %+15d\n" 1071 3.14156295 32589
Line: 01071           3.142 Result:          +32589     # 注意第一个数字和第二个数字之间的间隔
(base) ➜  playground printf "%s\t%s\t%s\n" str1 str2 str3
str1	str2	str3
```

22、Unix在技术和科学用户中流行的原因之一（除了为各种软件开发提供强大的多任务多用户环境之外），是它提供了可用于生成许多**类型文档**的工具，特别是科学和学术出版物。 第一个格式化程序是`roff`。继承自`roff`程序的，包括`nroff`和`troff`；以及基于 Donald Knuth 的TeX排版系统。

`nroff`程序用于格式化文档以输出到使用等宽字体的设备，如字符终端和打字机式打印机。在它刚面世时，这几乎包括了所有连接在计算机上的打印设备。 稍后的`troff`程序格式化用于排版机输出的文档，也就是“camera-ready”（可供拍摄成印刷版的）类型的用于商业打印的设备。今天的大多数电脑打印机都能够模拟排版机的输出。`roff`家族还包括一些用于准备文档部分的程序。这些包括`eqn`（用于数学方程）和`tbl`（用于表）。TeX系统（稳定形式）首先在1989年出现，并在某种程度上取代了`troff`作为排版机输出的首选工具。 

今天的大部分文件都是由能够**一次性完成排字和布局**的文字处理器生成的。 在图形文字处理器出现之前，需要两步来生成文档。首先用文本编辑器排字，接着用诸如`troff`之类的处理器来格式化。格式化程序的说明通过标记语言的形式插入到已排好字的文本当中。类似这种过程的现代例子是网页。它首先由某种文本编辑器排好字，然后由使用 HTML 作为标记语言的 Web 浏览器渲染出最终的页面布局。

我们总是要使用的手册页`man`就是通过`groff`渲染的。下面给出了原始文档和渲染后的文档之间的对比：
```shell
(base) ➜  man1 tail /usr/share/man/man1/ls.1
utility conforms to
.St -p1003.1-2001 .
.Sh HISTORY
An
.Nm ls
command appeared in
.At v1 .
.Sh BUGS
To maintain backward compatibility, the relationships between the many
options are quite complex.
(base) ➜  man1 man ls | tail
     The ls utility conforms to IEEE Std 1003.1-2001 (``POSIX.1'').

HISTORY
     An ls command appeared in Version 1 AT&T UNIX.

BUGS
     To maintain backward compatibility, the relationships between the many
     options are quite complex.

BSD                              May 19, 2002                              BSD
```
有TeX使用经验的同学一定心领神会。

一个简单的例子：使用`groff -mandoc /usr/share/man/man1/ls.1 > foo.ps`命令将渲染号的文档内容存放到名为`foo.ps`的postscript文件中。PostScript 是一种页面描述语言，用于将打印页面的内容描述给类似排字机的设备。在macOS中使用preview打开该文件时，会自动调用`ps2pdf`将其转换为pdf文档以供阅读。

总结：像`fmt`和`pr`这种比较简单的格式化工具会在 生成比较短的文件时发挥很多用途，而`groff`和其他工具则会在写书的时候用上。

23、打印

和计算机一样，前 PC 时代的打印机都很大、很贵，并且很集中。1980年的计算机用户都是在离电脑很远的地方用一个连接电脑的终端来工作的，而打印机就放在电脑旁并受到计算机管理员的全方位监视。由于当时打印机既昂贵又集中，而且都工作在早期的 Unix 环境下，人们从实际考虑通常都会多人共享一台打印机。为了区别不同用户的打印任务，每个打印任务的开头都会打印一张写着用户名字的标题页，然后计算机工作人员会用推车装好当天的打印任务并分发给每个用户。

80年代的打印机技术有两方面的不同。首先，那时的打印机基本上都是打击式打印机。打击式打印机使用撞针打击色带的机械结构在纸上形成字符。这种流行的技术造就了当时的菊轮式打印和点阵式打印。

早期打印机的特点是它使用设备内部固定的一组字符集。比如，一台菊轮式打印机只能打印固定在其菊花轮花瓣上的字符，就这点而言打印机更像是高速打字机。大部分打字机都使用等宽字体，意思是说每个字符的宽度相等，页面上只有固定的区域可供打印，而这些区域只能容纳固定的字符数。大部分打印机采用横向10字符每英寸（CPI）和纵向6行每英寸（LPI）的规格打印，这样一张美式信片纸就有横向85字符宽纵向66行高，加上两侧的页边距，一行的最大宽度可达80字符。据此，使用等宽字体就能提供所见即所得（WYSIWYG，What You See Is What You Get）的打印预览。

一台类打字机的打印机会收到以简单字节流的形式传送来的数据，其中就包含要打印的字符。例如要打印一个字母a，计算机就会发送 ASCII 码97，如果要移动打印机的滑动架和纸张，就需要使用回车、换行、换页等的小编号 ASCII 控制码。使用控制码，还能实现一些之前受限制的字体效果，比如粗体，就是让打印机先打印一个字符，然后退格再打印一遍来得到颜色较深的效果的。

图形用户界面（GUI）的发展催生了打印机技术中主要的变革。随着计算机的展现步入更多以图形为基础的方式，打印技术也从基于字符走向图形化技术，这一切都是源于激光打印机的到来，它不仅廉价，还可以在打印区域的任意位置打印微小的墨点，而不是使用固定的字符集。这让打印机能够打印成比例的字体（像用排字机那样），甚至是图片和高质量图表。

然而，从基于字符的方式到转移到图形化的方式提出了一个严峻的技术挑战。原因如下：使用基于字符的打印机时，填满一张纸所用的字节数可以这样计算出来（假设一张纸有60行，每行80个字符)：60 × 80 = 4800字节。相比之下，用一台300点每英寸（DPI）分辨率的激光打印机（假设一张纸有8乘10英寸的打印区域）打印则需要 (8 × 300) × (10 × 300) / 8 = 900,000字节。当时许多慢速的个人电脑网络无法接受激光打印机打印一页需要传输将近1兆的数据这一点，因此，很有必要发明一种更聪明的方法。这种发明便是页面描述语言（PDL）。PDL 是一种描述页面内容的编程语言。简单的说就是，“到这个地方，印一个10点大小的黑体字符 a ，到这个地方……” 这样直到页面上的所有内容都描述完了。第一种主要的 PDL 是 Adobe 系统开发的 PostScript，直到今天，这种语言仍被广泛使用。PostScript 是专为印刷各类图形和图像设计的完整的编程语言，它内建支持35种标准的高质量字体，在工作时还能够接受其他的字体定义。最早，对 PostScript 的支持是打印机本身内建的。这样传输数据的问题就解决了。**相比基于字符打印机的简单字节流，典型的 PostScript 程序更为详细，而且比表示整个页面的字节数要小很多。**

一台 PostScript 打印机接受PostScript文件作为输入。打印机有自己的处理器和内存（通常这让打印机比连接它的计算机更为强大），能执行一种叫做 PostScript 解析器的特殊程序用于读取输入的 PostScript 文件并生成结果导入打印机的内存，这样就形成了要转移到纸上的位（点）图。这种将页面渲染成大型位图（bitmap）的过程有个通用名称作光栅图像处理器（raster image processor），又叫 RIP。多年之后，电脑和网络都变得更快了。这使得 RIP 技术从打印机转移到了主机上，还让高品质打印机变得更便宜了。

当前 Linux 系统采用两套软件配合显示和管理打印。第一，CUPS（Common Unix Printing System），用于提供打印驱动和打印任务管理；第二，Ghostscript，一种 PostScript 解析器，作为 RIP 使用。

CUPS 通过创建并维护打印队列来管理打印机。如前所述，Unix 下的打印原本是设计成多用户共享中央打印机的管理模式的。由于打印机本身比连接到它的电脑要慢，打印系统就需要对打印任务进行调度使其保持顺序。CUPS 还能识别出不同类型的数据（在合理范围内）并转换文件为可打印的格式。

**将打印任务送至打印机**:

CUPS 打印体系支持两种曾用于类 Unix 系统的打印方式。一种，叫 Berkeley 或 LPD（用于 Unix 的 Berkeley 软件发行版），使用 lpr 程序；另一种，叫 SysV（源自 System V 版本的 Unix），使用 lp 程序。这两个程序的功能大致相同。许多 Linux 发行版允许你定义一个输出 PDF 文件但不执行实体打印的“打印机”，这可以用来很方便的检验你的打印命令。另一个选择是 a2ps ，本意为 ASCII to PostScript，它是用来为 PostScript 打印机准备要打印的文本文件的。多年后，程序的功能得到了提升，名字的含义也变成了 Anything to PostScript。尽管名为格式转换程序，但它实际的功能却是打印。它的默认输出不是标准输出，而是系统的默认打印机。

**监视和控制打印任务**：
- `lpstat` - 显示打印系统状态
- `lpq` - 显示打印机队列状态
- `lprm`和`cancel` - 取消打印任务

### 编译
24、编译程序<br>
（1）对于许多桌面用户来说，编译是一种失传的艺术。以前很常见，但现在主要是由系统发行版提供商维护巨大的预编译的二进制仓库，准备供用户下载和使用。

（2）为什么要自己编译软件？
- 可用性。尽管系统发行版仓库中已经包含了大量的预编译程序，但是一些发行版本不可能包含所有期望的应用。 在这种情况下，得到所期望程序的唯一方式是编译程序源码。
- 及时性。虽然一些系统发行版专门打包前沿版本的应用程序，但是很多不是。这意味着，为了拥有一个最新版本的程序，编译是必需的。

最主要的编译工具是`make`。

通常来说，解释型程序执行起来要比编译程序慢很多。这是因为每次解释型程序执行时，程序中每一条源码指令都需要翻译， 而一个已经编译好的程序，一条源码指令只翻译了一次，翻译后的指令会永久地记录到最终的执行文件中。那么为什么解释型程序这样流行呢？对于许多编程任务来说，原因是“足够快”，但是真正的优势在于，**开发解释型程序要比编译程序快速且容易**。通常程序开发需要经历一个不断重复的写码、编译和测试周期。随着程序变得越来越大，编译阶段会变得相当耗时。解释型语言删除了编译步骤，这样就加快了程序开发。

（3）用一个示例分析`make`编译程序的全过程：

【1】编写/下载项目源代码：<br>
使用`ncftp`从`ftp.gnu.org/gnu/diction/`下载项目代码`diction-1.11.tar.gz`放到`src`目录中。Linux系统发行版在安装源码时会默认选择`/usr/local/src`，从而供多个用户使用。**通常提供的源码形式是一个压缩的 tar 文件。有时候称为 tarball，这个文件包含源码树， 或者是组成源码的目录和文件的层次结构**。该 diction 程序，像所有的 GNU 项目软件，遵循着一定的源码打包标准。其它大多数在 Linux 生态系统中 可用的源码也遵循这个标准。该标准的一个条目是，当源码 tar 文件打开的时候，会创建一个目录，该目录包含了源码树， 并且这个目录将会命名为`project-x.xx`，其包含了项目名称和它的版本号两项内容。这种方案能在系统中方便安装同一程序的多个版本。 然而，通常在打开 tarball 之前检验源码树的布局是个不错的主意。**一些项目不会创建该目录，反而，会把文件直接传递给当前目录。 这会把你的（除非组织良好的）src 目录弄得一片狼藉**。

【2】检查源码树：<br>
在源码树中，我们看到大量的文件。属于 GNU 项目的程序，还有其它许多程序都会，提供文档文件 README，INSTALL，NEWS，和 COPYING。这些文件包含了程序描述，如何建立和安装它的信息，还有其它许可条款。在试图建立程序之前，仔细阅读 README 和 INSTALL 文件，总是一个不错的主意。

在C语言中，我们将源码分割成易于管理的源码块并放到不同的.c文件中，以.h作为扩展符的头文件包含了对源码文件和库中的模块的描述。为了让编译器链接到模块，编译器必须接受所需的所有模块的描述，来完成整个程序。源码树之外的头文件是库提供的，这些头文件在安装编译器的时候就会被安装。

【3】构建程序：
```shell
./configure
make
```
`configure`程序是一个 shell 脚本，由源码树提供。它的工作是分析程序构建环境。大多数源码会设计为可移植的。也就是说，它被设计成能够在不止一种类 Unix 系统中进行构建。但是为了做到这一点，在建立程序期间，为了适应系统之间的差异，`configure`程序就会对源码可能需要经过轻微的调整。`configure`也会检查是否安装了必要的外部工具和组件。让我们运行`configure`命令。 因为`configure`命令所在的位置不是位于 shell 通常期望程序所呆的地方，我们必须明确地告诉 shell 它的位置，通过在命令之前加上`./`字符。

运行`./configure`之后会测试系统环境并生成一系列文件，包含Makefile。大多数 makefile 文件由行组成，每行定义一个目标文件， 在这种情况下，目标文件是指可执行文件 diction，还有目标文件所依赖的文件。剩下的行描述了从目标文件的依赖组件中 创建目标文件所需的命令。在这个例子中，我们看到可执行文件 diction（最终的成品之一）依赖于文件 diction.o，sentence.o，misc.o，getopt.o，和 getopt1.o都存在。

使用`make`进行构建是**增量式**的，如果没有新内容需要构建，再次运行`make`什么也不会做，而不是重头构建呢所有源码。这对于拥有数百万行源码的大型项目而言，大大缩短了编译时长。

【4】最后，使用如下命令：
```shell
make install
```
将程序安装到系统目录中（通常是`/usr/local/bin`）。