## 三、常见任务和基本工具
1、软件包管理是指系统中一种安装和维护软件的方法。今天，通过从**Linux发行版**中安装的软件包，已能满足许多人所有的软件需求。这不同于早期的Linux，人们需要下载和编译源码来安装软件。编译源码没有任何问题，事实上，拥有对源码的访问权限是Linux的伟大奇迹。它赋予我们检测和提高系统性能的能力。只是若有一个预先编译好的软件包处理起来要相对容易快速些。

2、不同的Linux发行版使用不同的打包系统，一般而言，大多数发行版分别属于两大包管理技术阵营：Debian的`.deb`和红帽的`.rpm`。
| 包管理系统 |  发行版（部分列表）
| --- | ---
| Debian Style (`.deb`) | Debian, Ubuntu, Xandros, Linspire
|Red Hat Style (`.rpm`) | Fedora, CentOS, Red Hat Enterprise Linux, OpenSUSE, Mandriva, PCLinuxOS

3、软件管理<br>
（1）Linux系统中几乎所有的软件都可以在互联网上找到。其中大多数软件由发行商以**包文件**的形式提供，剩下的则以源码形式存在，可以手动安装。

（2）在包管理系统中，软件的基本单元是包文件。**包文件是一个构成软件包的文件压缩集合。**一个软件包可能由大量程序以及支持这些程序的数据文件组成。除了安装文件之外，软件包文件也包括关于这个包的元数据，如软件包及其内容的文本说明。另外，许多软件包还包括预安装和安装后脚本，这些脚本用来在软件安装之前和之后执行配置任务。

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

（2）大多数情况下，我们只要把设备连接到系统中，它就能工作。但是，对于有极端的存储需求和复杂的配置要求的服务器，仍然需要手动进行设备管理。**管理存储设备的第一步是把设备连接到文件系统树中。这个叫做”挂载”的过程允许设备连接到操作系统中。**类Unix的操作系统，比如Linux，在单一文件系统树中维护连接在各个节点的各种设备。这与其它操作系统形成对照，比如说MS-DOS和Windows系统中，每个设备（例如`C:\`，`D:\`，等）保持着单独的文件系统树。

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

（3）`locate`程序只能依据文件名来查找文件，而`find`程序能基于**各种各样的属性**搜索一个**给定目录（以及它的子目录）**来查找文件。 `find`的`-type`参数限定搜索目标的类型。可选项有：

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

7、归档和备份<br>
（1）掌握常用的管理文件集合的程序：
- `gzip` – 压缩或者展开文件
- `tar` – 磁带打包工具
- `zip` – 打包和压缩文件
- `rsync` – 同步远端文件和目录

（2）数据压缩