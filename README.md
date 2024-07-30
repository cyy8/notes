# notes

My GitHub：https://github.com/cyy8/notes


TODO:
Linux/ Mac 安装软件 / 管理

- Mac,  brew;  brew install htop
- Ubuntu, apt; apt update; apt install -y htop
- Centos, yum; yum -y install htop  

Centos7 issue: mirrorlist.centos.org no longer resolve?
https://serverfault.com/questions/1161816/mirrorlist-centos-org-no-longer-resolve
To resolve the issue you can mass update all .repo files:

```bash
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo
```


# mac install brew 

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# Day 12 20240730 （2h）

## [Markdown学习](https://www.markdowntutorial.com/lesson/1/)

### italics bold monospace
- italic, surround words with an underscore ( _ ). 
    - eg. _good_
- bold, surround words with two asterisks ( ** ). 
    - eg. **bold**
- italic and bold,either is ok 
    - eg. **_both_** , _**both**_
- highlight with monospace
    - `mono`

### header
- Preface the phrase with a hash mark (#). 
- You place the same number of hash marks as the size of the header you want. header one = # Header One
### link
- brackets ( [ ] ), and then wrap the link in parentheses ( ( ) ) 
    - eg. You can [search for it](www.google.com) on the website.
- make links within headings 
    - eg. The line is Header four and add links to the BBC
        - #### The Latest News from [the BBC](www.bbc.com/news) 
### images
- inline image link: an exclamation point ( ! ), wrap the alt text in brackets ( [ ] ), and then wrap the link in parentheses ( ( ) )
    - eg. ![A pretty tiger](https://upload.wikimedia.org/wikipedia/commons/5/56/Tiger.50.jpg)
- reference image: an exclamation point, then provide two brackets for the alt text, and then two more for the image tag, like this: ![The founding father][Father]. And at the bottom of your Markdown page, you'll define an image for the tag, like this: [Father]: http://octodex.github.com/images/founding-father.jpg
    - eg. 
    ![Black cat][Black]    
    ![Orange cat][Orange]

    [Black]: https://upload.wikimedia.org/wikipedia/commons/a/a3/81_INF_DIV_SSI.jpg

    [Orange]: http://icons.iconarchive.com/icons/google/noto-emoji-animals-nature/256/22221-cat-icon.png
### blockquotes
- blockquote: preface a line with the "greater than" caret (>) eg. 
    >In a few moments he was barefoot
- quote spans multiple paragraphs：blank lines must contain the caret character. eg.
    > His words seemed to have struck some deep chord in his own nature. Had he spoken
    >
    > —Of whom are you speaking? Stephen asked at length.
    >
    > Cranly did not answer.
### lists
- unordered list: preface with an asterisk ( * ) (- + also work) and a space
    eg. 
    * a  
    * b
        + c     (# to add some sub-list, indent each asterisk one space more than the preceding item)
            - d
- ordered list：with numbers
    eg. 
    1. a
    2. b
    3. c
### paragraphs
- hard break(not recommended): to forcefully insert a new line by inserting a blank line  
    eg. 
    
    Do I contradict myself?

    Very well then I contradict myself,
- soft break: each line end up with two space and then start a new line.
    eg.   
    Do I contradict myself?  
    Very well then I contradict myself,  
### strike through（vs不兼容）
    ~~It should be deleted~~

### task lists（vs不兼容）
    - [x] Completed task
    - [~] Inapplicable task
    - [ ] Incomplete task  

## 图解HTTP
how to read this book：skip chapter 5、8、9、11，skim chapter 6
### Chapter 1
#### Web协议和HTTP
* *Web浏览器*通过地址栏指定的*URL*，从*Web服务器*获取文件资源（resource）等信息，从而显示出Web页面
    * URL：Uniform Resource Locator 统一资源定位器
* Web使用一种名为*HTTP*的协议作为规范。That's to say，Web是建立在HTTP协议上通信的
    * HTTP：HyperText Transfer Protocol 超文本传输协议
* HTTP版本：当前主流版本是1997年公布的HTTP/1.1。HTTP/2.0定制中
#### TCP/IP
* 通常使用的网络（包括互联网）是在*TCP/IP*协议族的基础上运作的。HTTP是其子集。
* TCP/IP：与互联网相关联的协议集合起来，称为～
* TCP/IP协议族分层：
    * 应用层：决定了向用户提供应用服务时通信的活动。**HTTP**和**DNS**在该层
    * 传输层：提供处于网络连接中两台计算机间的数据传输。传输层有2个性质不同的协议：TCP和UDP
        * TCP Transmission Control Protocol 传输控制协议
        * UDP User Data Protocol 用户数据报协议
    * 网络层：处理网络上流动的数据包。数据包是网络传输的最小数据单位 **IP在该层**
    * 链路层：也称网络接口层。硬件上的范畴均在链路层作用范围内。
* **封装**：发送端层与层传输数据时，每经过一层时必定打上该层所属的首部信息。反之，接收端层间传输数据时，每经过一层会把对应的首部消去。这种把数据信息包装起来的做法称为封装（encapsulate）。#待加图

#### 与HTTP关系密切的协议 之 IP协议
* IP（Internet Protocol）网际协议位于网络层。
    * 注意区分 IP协议和IP地址，两者不是一回事
    * IP协议作用是把数据包传给对方，要保证可以顺利传输，需要很多条件，其中2个很重：IP地址和MAC地址
    * IP地址指明了节点被分配到的地址；MAC地址是网卡所属的固定地址
    * IP地址和MAC地址可以配对；IP地址可变，MAC基本不变
* ARP协议：用以解析地址。可以根据IP地址反查出对应的MAC地址
#### 与HTTP关系密切的协议 之 TCP协议
* TCP位于传输层，提供字节流服务
    *字节流服务（Byte Stream Service）：为方便传输，将大块数据分隔成以**报文段（segment）**为单位的数据报进行管理
* 三次握手 three-way handshaking
    1. 发送端首先发送一个带**SYN**标志的数据报给对方
    2. 接收端收到后，会穿一个带有**SYN/ACK**标志的数据包以示传达确认消息
    3. 最后，发送端再回传一个带**ACK**表示的数据包，代表“握手”结束。
    
    >补充说明：1. 握手过程中使用了TCP的表示：SYN synchronize 和 ACK acknowledgement  
    >2. 若在某个阶段莫名中断，TCP协议会再次以相同的顺序发送相同的数据包
#### 负责解析域名的DNS服务
* DNS（Domain Name System）：位于应用层。提供域名到IP地址的解析服务
* DNS 协议可以通过域名查IP，反过来也可以

#### URI和URL
- URI Uniform Resource Identifier：某个协议方案表示的资源的定位表示符
- URI用字符串标识某一互联网资源，而URL表示资源的地点（互联网上所处的位置）。so URL是URI的子集

### Chapter 2
#### 客户端和服务器端
* 请求访问文本或图像等资源的一端为客户端；提供资源响应的一端为服务器端
* 两台计算机作为C/S，两者角色可能会互换
#### 方法
* GET 获取资源
* POST 传输实体主体（entity body）
* PUT 传输文件
* HEAD 获得报文首部
* DELETE 删除文件
* OPTIONS 询问支持的方法
* TRACE 追踪路径
#### 持久链接
* 特点：只要任意一端没有明确提出断开连接，则保持TCP连接状态
* 优点
    * 减少TCP连接的重复建立和断开所造成的额外开销
    * 减轻服务端的负载
    * 减少开销的那部分时间，使HTTP请求和响应能更早地结束，从而使Web页面的显示速度相应地提高了
* HTTP/1.1 都是默认持久链接。1.0内未标准化
#### 管线化
* 持久链接使得多数请求以管线化（pipelining）方式发送成为可能
* 同时并行发送多个请求，而不需要一个接一个地等待相应
* 管线化可以让请求更快结束。请求数越多，时间差就越明显

#### Cookie
* HTTP是无状态协议，不管理之前发生过的请求和响应状态
* Cookie 会根据服务器端发送的响应报文内首部字段为**Set-Cookie**的信息，通知客户端保存cookie。下次客户端再发送请求时，客户端会自动在请求报文中加入Cookie值后发送出去

### Chapter 3
#### HTTP报文
* HTTP报文结构
    * 报文首部：服务器端或客户端需处理的请求或响应的内容及属性
    * 空行（区分首部和主体）
    * 主体：应被发送的数据
* 报文和实体的差异
    * 报文 message，是HTTP通信中的基本单位
    * 实体 entity，作为请求或响应的有效载荷数据被传输。有实体首部和实体报文组成
    * 通常，报文主体=实体主体。只有当传输中编码时，实体主体的内容变化，才会与报文主体产生差异
### Chapter 4
#### 状态码（review）
* 200 OK
* 301 Mover Permanently 永久重定向：说明以后应使用新URI
* 302 临时性重定向：本次用新的URI访问
* 400 Bad request 请求报文中有语法错误
* 401 Unauthorized 请求需要通过认证信息
* 403 Forbidden 对请求资源的访问被服务器拒绝
* 404 Not Found 服务器上无法找到请求的资源

### Chapter 6

### Chapter 7

### Chapter 10



# Day 11 20240729

## 网络是怎么连接的 （40 min）

how to read this book：focus on chapter 1；skim the rest （skip the charts and pictures，try to understand concepts）

### Step 1 生成HTTP请求消息

1. 输入URL
用HTTP协议访问Web服务器时
http://user:password@www.baidu.com:80/dir/file1.htm
#user:password可省略  
#www.baidu.com web服务器域名；如果访问FTP服务器，www则换成ftp  
#80 端口号，可省略  
#/dir/file1.htm 文件的路径名
2. 浏览器解析URL
3. 文件名路径可省略
4. HTTP的基本思路
客户端通过 方法+URI 发送请求消息，服务器通过 状态码 响应消息  
#http的主要方法：GET POST HEAD OPTIONS PUT DELETE TRACE CONNECT
5. 生成HTTP的请求消息
#请求行：请求行+消息头  
#响应消息：状态行+消息头
6. 发送消息后收到响应
    - 200 OK
    - 301 重定向 302临时性重定向
    - 4XX 客户端有问题
        - 400 bad request 语法错误
        - 401 unauthorized 需要认证
        - 403 forbidden 服务器拒绝
        - 404 找不到该资源
    - 5XX 服务器有问题

### Step 2 向DNS服务器查询Web服务器的IP地址
1. IP地址基本知识：每个设备都有一个IP地址
2. 域名和IP地址：机器喜欢数字，so IP地址；但人类不好记数字，so有域名
3. 查询IP地址：通过DNS服务器，调用了socket库的解析器

### Step 3 DNS服务器接力
1. 顺藤摸瓜，直到找到存放请求文件的DNS
2. 缓存：加快响应速度

### Step 4 委托协议栈发消息
1. 发委托时，需要按指定顺序调用socket库

（本书Chapter1内容结束）

## 命令大全 C16 （16:10-16:30 ）
* ip、ftp没有  
* wget类似curl 主要用于下载  
* ssh重点 难 先了解 以后实践 阿里云vm virtual machine
* traceroute netstat wget测试 其他阅读

###  ping （见0727 网络测试工具）
###  traceroute（自习室没网，回家测 0730补充）
traceroute程序可以列出网络流量从本地系统到指定主机经过的所有**跳（hop）**数
```bash
traceroute 域名

➜  notes git:(main) ✗ traceroute jd.com
traceroute: Warning: jd.com has multiple addresses; using 211.144.24.218
traceroute to jd.com (211.144.24.218), 64 hops max, 40 byte packets
 1  * * *
 2  192.168.1.1 (192.168.1.1)  31.554 ms  20.194 ms  20.986 ms
 3  180.159.36.1 (180.159.36.1)  23.289 ms *  26.588 ms
 4  61.172.65.202 (61.172.65.202)  23.791 ms * *
 5  61.152.52.177 (61.152.52.177)  20.116 ms
    61.172.64.169 (61.172.64.169)  21.821 ms
    61.152.54.185 (61.152.54.185)  19.010 ms
 6  61.152.26.42 (61.152.26.42)  21.621 ms *
    61.152.24.118 (61.152.24.118)  29.394 ms
 7  * * *   #星号待查是啥 #当某个步骤的响应超时时，就会使用星号来表示。 这通常是由于被防火墙过滤、网络故障或者网络设备不返回TTL超时错误消息等原因所导致的。
 8  202.97.18.22 (202.97.18.22)  48.171 ms
    202.97.18.10 (202.97.18.10)  47.862 ms
^C
```

###  netstat
用于检查各种网络设置和统计信息；-ie可检查系统的网络接口
###  wget 
用于Web和FTO网站下载文件，可以实现递归下载、后台下载、断点续传等

##  Linux 系统命令及Shell脚本（16:40-17:30） 
how to read this book：
1. chapter 6 网络管理 ifconfig dns ping（见0727） 
2. chapter 7 进程管理（整章）
### 进程含义
- 进程：程序的一次执行过程，程序的运行实例，动态
- 进程的3种状态：运行态、就绪态、阻塞态
- 进程之间的关系：互斥又同步
    - 互斥：不能同时进行，必须one by one
    - 同步：通过某种通信机制实现信息交互
- 进程和程序的区别：
    - 程序是动作执行的描述，静态；进程则是实际执行的过程，动态
    - 类比：做一件事需要列步骤，这些步骤写在静态的纸上，即“程序”；将步骤付诸实施的过程，即“进程”
### 进程观察之 ps、top

#### 查看进程   ps -ef  VS  ps aux

- ps -ef 比较紧凑
- ps aux 多显示 %CPU %MEM  使用率 还有 STAT 

```bash
root@fefb8747976a:/# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 08:06 ?        00:00:00 sleep infinity
root        27     0  0 08:27 pts/0    00:00:00 /bin/sh
root@fefb8747976a:/# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   2200  1152 ?        Ss   08:06   0:00 sleep infinity
root        27  0.0  0.0   2304  1280 pts/0    Ss   08:27   0:00 /bin/sh
```

#### top 查看动态进程
ps输出只是当前查询状态下进程瞬间的状态信息，及时动态查看进程用top命令：
```bash
top - 08:58:28 up  8:44,  0 users,  load average: 0.20, 0.14, 0.10 #服务器基础信息
Tasks:   3 total,   1 running,   2 sleeping,   0 stopped,   0 zombie    #当前系统进程概况，一共3个，1个运行，2个休眠
%Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st #CPU信息
MiB Mem :   7940.8 total,   6526.6 free,    387.0 used,   1027.2 buff/cache     #物理内存的使用状态
MiB Swap:   1024.0 total,   1024.0 free,      0.0 used.   7364.2 avail Mem      #虚拟内存的使用状态

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                       
    1 root      20   0    4116   3200   2816 S   0.0   0.0   0:00.03 bash                                                                                          
   16 root      20   0    4116   3200   2816 S   0.0   0.0   0:00.01 bash                                                                                          
   27 root      20   0    6680   2688   2304 R   0.0   0.0   0:00.00 top  

# 若要显示更多，可按 字母键 f #没看懂结果
```

### 进程终止之 kill、killall
一般kill跟ps一起使用，因为kill后面跟被终止进程的PID，典型的方法是：
```bash
kill 进程ID
```

已知进程A，快速找出其PID的方法：
```bash 
ps -ef | grep A     #方法一  
pidof A             #方法二
```

kill-l可以查看kill可跟的信号代码，其中常用的有3个：
    - HUP（重启）
    - KILL（强行杀掉）
    - TERM（正常结束）

### 查询进程打开的文件：lsof（list open files）

# Day 10 20240728
每天5分钟玩转docker  
read Chapter 2、3、4；the rest not now

## Docker 基础命令
* 查看已下载到本地的镜像 docker images

```bash
  notes git:(main) ✗ docker images     #docker images 查看已下载到本地的镜像
REPOSITORY                 TAG       IMAGE ID       CREATED        SIZE
ubuntu                     22.04     d04dcc2ab57b   4 weeks ago    69.2MB
ubuntu                     24.04     ffb64c9b7e8b   7 weeks ago    101MB
docker/welcome-to-docker   latest    648f93a1ba7d   8 months ago   19MB
```
* 查看运行中的容器 docker ps
```bash
➜  notes git:(main) ✗ docker ps       #docker ps 查看运行中的容器
CONTAINER ID   IMAGE                             COMMAND                   CREATED       STATUS       PORTS                  NAMES
f9d7efe80d21   centos:centos7                    "/bin/bash -c 'echo …"   2 hours ago   Up 2 hours                          centos7
ce4c47585e31   ubuntu:24.04                      "/bin/bash -c 'echo …"   2 hours ago   Up 2 hours                          ubuntu-2404
cbadb9479ba5   docker/welcome-to-docker:latest   "/docker-entrypoint.…"   3 hours ago   Up 3 hours   0.0.0.0:8088->80/tcp   welcome-to-docker
```
* 搜索docker hub中的镜像（无需开浏览器）`docker search httpd`
```bash
docker search httpd 
NAME                           DESCRIPTION                                      STARS     OFFICIAL
httpd                          The Apache HTTP Server Project                   4756      [OK]
paketobuildpacks/httpd                                                          0         
paketobuildpacks/php-httpd                                                      0              
mprahl/s2i-angular-httpd24     An S2I image for building and running Angula…   3         
httpdocker/kubia                       
```

* ps -a 显示所有的容器，包括已退出的
```bash
➜  notes git:(main) ✗ docker run ubuntu:22.04  
➜  notes git:(main) ✗ docker ps -a           # docker ps -a 显示所有的容器，包括已退出的
CONTAINER ID   IMAGE                             COMMAND                   CREATED          STATUS                      PORTS                  NAMES
03c1fb510166   ubuntu:22.04                      "/bin/bash"               26 seconds ago   Exited (0) 26 seconds ago   # ubuntu:22.04 已退出
```
* -d后台运行 sleep infinity 让容器保持运行不退出

```bash
➜  notes git:(main) ✗ docker run -d ubuntu:22.04 /bin/bash -c "sleep infinity" #-d后台运行 sleep infinity 让容器保持运行不退出
80c1031379a6b2226dd4a3c3c6f068be95f66b051fb71a38c13f63e0d68b6865
➜  notes git:(main) ✗ docker ps
CONTAINER ID   IMAGE                             COMMAND                   CREATED          STATUS          PORTS                  NAMES
80c1031379a6   ubuntu:22.04                      "/bin/bash -c 'sleep…"   7 seconds ago    Up 6 seconds                           awesome_stonebraker
c27524f572c8   ubuntu:22.04                      "/bin/bash -c 'sleep…"   45 seconds ago   Up 44 seconds  
```

```bash
bash -c #-c string If the -c option is present, then commands are read from string.
➜  notes git:(main) ✗ bash -c "echo hi"
hi
```
* docker stop 停止容器命令

```bash
docker stop 停止容器命令 ，后跟容器ID或NAMES
docker rm 删除容器
docker ps -a 显示所有容器，包括已停止的
docker run --name 指定容器名字
➜  notes git:(main) ✗ docker run --name cyy -d ubuntu:22.04 /bin/bash -c "sleep infinity"             
fefb8747976ad54465d6df6a47824819dc7f5e0a8bc299fae786bf6e66428c5f
➜  notes git:(main) ✗ docker ps -a                                                       
CONTAINER ID   IMAGE                             COMMAND                   CREATED         STATUS         PORTS                  NAMES
fefb8747976a   ubuntu:22.04                      "/bin/bash -c 'sleep…"   6 seconds ago   Up 6 seconds                          cyy

```
* docker `exec`/`exit` 进入/退出容器
```bash
# exec 进入容器
➜  notes git:(main) ✗ docker exec -it cyy bash #-it表示打开交互终端，进入容器
# exit 退出容器
```

* docker logs 查看容器日志
* docker run -it 
    * 启动后进入容器，退出后容器自动删除；用于一次性  


```bash
# How to Keep Docker Container Running
https://kodekloud.com/blog/keep-docker-container-running/


docker run -d --name ubuntu-2404  ubuntu:24.04 /bin/bash -c "echo 'Hello World'; sleep infinity"
docker run -d --name centos7  centos:centos7 /bin/bash -c "echo 'Hello World'; sleep infinity"


# How To Fix “bash: ping: command not found” In Ubuntu Docker Containers
https://medium.com/@devtonight/how-to-fix-bash-ping-command-not-found-in-ubuntu-docker-containers-41c5bf57c69a
That means the official Ubuntu Docker image comes with bare minimum packages installed. So, unfortunately, famous tools like ping and ifconfig (learn how to install) commands will not be there right after we created a container using the official Ubuntu image. 

How to Fix "bash: ifconfig: command not found" in Ubuntu Docker Containers
https://devtonight.com/articles/how-to-fix-bash-ifconfig-command-not-found-in-ubuntu-docker-containers

apt-get update; apt install -y iproute2 iputils-ping net-tools dnsutils curl wget git vi 
```

# Day 9 20240727

>Roadmap  
>curl  ->  http  ->   dns  ->   tcp/ip   网络

## Linux 系统命令及Shell脚本 
how to read this book：chapter 6 网络管理`ifconfig` `dns` `ping` chapter 7 进程管理（整章）

### 使用ifconfig检查和配置网卡
ifconfig命令，可以输出当前系统中所有处于活动状态的网络接口
```bash
ifconfig en0
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
        options=400<CHANNEL_IO>
        ether 50:ed:3c:15:9f:a8
        inet6 fe80::1cc8:afc:bd6b:f4f6%en0 prefixlen 64 secured scopeid 0xb 
        inet 172.16.2.36 netmask 0xffff0000 broadcast 172.16.255.255
        nd6 options=201<PERFORMNUD,DAD>
        media: autoselect
        status: active
```

### DNS客户端配置
/etc/hosts: 记录主机名和IP的对应关系。当主机数量巨大，列表过长导致使用不便，于是DNS系统应运而生。
但hosts文件仍被保留，用于：1. 加快域名解析：访问网络时，系统会优先查看hosts文件中是否有记录，如有，则不需要请求DNS服务器 2. 方便小型局域网用户使用，如公司内部应用，不需要专门设置DNS服务器
```bash
➜  notes git:(main) ✗ cat /etc/hosts
127.0.0.1       localhost  # IP地址➕域名
255.255.255.255 broadcasthost
……
```

/etc/resolv.conf
DNS是全互联网上主机名及其IP地址对应关系的数据库.
nameserver 后面跟DNS服务器的IP地址，可以设置2～3个nameserver，但优先查询第一个
```bash
 cat /etc/resolv.conf 
nameserver 114.114.114.114      #国内主流DNS服务器
nameserver 8.8.8.8              #国外谷歌的DNS服务器。另，1.1.1.1
```

### 网络测试工具 ping
- ping程序作用：测试是否可达另一台主机（是否可以连接其他主机，测网）
- ping失败的原因：1. 另一台主机故障 2. 防火墙禁止ping，造成包被丢弃
- ping方式：ping IP地址 或 ping 域名
- ping程序不会自己停止，control+c 停止；-c 指定ping次数
- 网络不好时，可以先ping 路由器IP，看局域网 丢包情况，再ping 网址，看到目标网址的丢包情况。
- 底层：执行ping命令时，主机发送的是ICMP（Internet Control Message Protocol）请求包
```bash
断开Wi-Fi时显示如下
➜  notes git:(main) ✗ ping 172.16.0.1 -c 2
PING 172.16.0.1 (172.16.0.1): 56 data bytes
ping: sendto: No route to host      #找不到路由器
ping: sendto: No route to host
Request timeout for icmp_seq 0
```

```bash
ping www.google.com 
PING www.google.com (199.59.148.20): 56 data bytes
Request timeout for icmp_seq 0
Request timeout for icmp_seq 1
^C
--- www.google.com ping statistics ---
3 packets transmitted, 0 packets received, 100.0% packet loss       #丢包率100%，无法ping

ping 172.16.0.1 #ping图书馆路由器的IP地址
PING 172.16.0.1 (172.16.0.1): 56 data bytes
64 bytes from 172.16.0.1: icmp_seq=0 ttl=64 time=18.670 ms
^C
--- 172.16.0.1 ping statistics ---
14 packets transmitted, 14 packets received, 0.0% packet loss       #0丢包率，连接良好，网络状态good
round-trip min/avg/max/stddev = 11.913/19.552/24.610/3.994 ms
```

### DNS（Domain Name Server）查询工具 host/dig/nslookup
host：查询DNS记录。域名作host的参数，命令返回该域名的IP：
```bash
➜  notes git:(main) ✗ host www.baidu.com          #host 域名，查询对应的IP地址
www.baidu.com is an alias for www.a.shifen.com.     #alias表示别名
www.a.shifen.com has address 180.101.50.242         #ipv4
www.a.shifen.com has address 180.101.50.188        
www.a.shifen.com has IPv6 address 240e:e9:6002:15c:0:ff:b015:146f    #ipv6
www.a.shifen.com has IPv6 address 240e:e9:6002:15a:0:ff:b05c:1278    
➜  notes git:(main) ✗ host www.baidu.com 1.1.1.1     # 指定服务器（1.1.1.1）查询
Using domain server:
Name: 1.1.1.1
Address: 1.1.1.1#53 #端口号一般都是53
Aliases: 

www.baidu.com is an alias for www.a.shifen.com.
www.a.shifen.com is an alias for www.wshifen.com.
www.wshifen.com has address 103.235.47.188
www.wshifen.com has address 103.235.46.96
```

相同功能还有 nslookup,dig:
```bash
  notes git:(main) ✗ nslookup www.baidu.com  #nslookup 域名
Server:         114.114.114.114
Address:        114.114.114.114#53

Non-authoritative answer:
www.baidu.com   canonical name = www.a.shifen.com.
Name:   www.a.shifen.com
Address: 180.101.50.242
Name:   www.a.shifen.com
Address: 180.101.50.188

➜  notes git:(main) ✗ nslookup www.baidu.com 1.1.1.1  # 指定DNS服务器
Server:         1.1.1.1
Address:        1.1.1.1#53

Non-authoritative answer:
www.baidu.com   canonical name = www.a.shifen.com.
www.a.shifen.com        canonical name = www.wshifen.com.
Name:   www.wshifen.com
Address: 103.235.47.188
Name:   www.wshifen.com
Address: 103.235.46.96
```


### 练习：提取某个网址对应的IP地址
```bash
nslookup abc.com | grep 'Address'| grep -v '#'| cut -f2 -d' '| tr '\n' ' '
99.84.133.46 99.84.133.97 99.84.133.98 bash-3.2$ 

#nslookup 关键词待搜索 DNS dig http
#grep 获取含有Address的行，并删除带有#的行
#cut 以空格为分隔符，提取第二列
#tr 将换行替换为空格，合并为一行 
```

```bash
➜  notes git:(main) ✗ dig www.baidu.com      # dig 域名          


;; ANSWER SECTION:
www.baidu.com.          667     IN      CNAME   www.a.shifen.com.
www.a.shifen.com.       127     IN      A       180.101.50.188
www.a.shifen.com.       127     IN      A       180.101.50.242

;; Query time: 29 msec
;; SERVER: 114.114.114.114#53(114.114.114.114)
;; WHEN: Sat Jul 27 16:19:34 CST 2024
;; MSG SIZE  rcvd: 101

➜  notes git:(main) ✗ dig www.baidu.com @1.1.1.1      # dig 域名 @符号：指定DNS服务器（必须有@）
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;www.baidu.com.                 IN      A

;; ANSWER SECTION:
www.baidu.com.          1184    IN      CNAME   www.a.shifen.com.
www.a.shifen.com.       14      IN      CNAME   www.wshifen.com.
www.wshifen.com.        284     IN      A       103.235.46.96
www.wshifen.com.        284     IN      A       103.235.47.188

;; Query time: 166 msec
;; SERVER: 1.1.1.1#53(1.1.1.1)
;; WHEN: Sat Jul 27 16:19:48 CST 2024
;; MSG SIZE  rcvd: 127

➜  notes git:(main) ✗ dig www.baidu.com @1.1.1.1 +short  # +short：简洁模式
www.a.shifen.com.
www.wshifen.com.
103.235.47.188
103.235.46.96

#提取上述文本中的IP地址
➜  notes git:(main) ✗ dig www.baidu.com +short |grep -v '[a-z]'
180.101.50.188
180.101.50.242
# 特征是去掉包含字母的行 grep -v 表示 invert-match 反选
# -v, --invert-match
             Selected lines are those not matching any of the specified patterns
```

curl  1h:  13pm-14pm

## cURL必知必会
### curl的用途及发音（1.2）
* curl工具：用于上传和下载URL指定的数据
* curl 命名：可以see（发音同C）到URL，所以称cURL；also 是个客户端（client），所以cURL
* curl发音
    * 同 curl
    * 作动词 curl sth 指使用非浏览器工具下载URL指定的文件或资源

### 命令行选项（2.1）
- 短选项  -v指切换到详细（verbose）模式
```bash
curl http://baidu.com       #普通显示
<html>
<meta http-equiv="refresh" content="0;url=http://www.baidu.com/">
</html>
➜  notes git:(main) curl -v http://baidu.com       #加-v verbose
* Host baidu.com:80 was resolved.
* IPv6: (none)
* IPv4: 39.156.66.10, 110.242.68.66
*   Trying 39.156.66.10:80...
* Connected to baidu.com (39.156.66.10) port 80
> GET / HTTP/1.1
> Host: baidu.com
> User-Agent: curl/8.6.0
> Accept: */*
> 
< HTTP/1.1 200 OK
< Date: Sat, 27 Jul 2024 05:09:59 GMT
< Server: Apache
< Last-Modified: Tue, 12 Jan 2010 13:48:00 GMT
< ETag: "51-47cf7e6ee8400"
< Accept-Ranges: bytes
< Content-Length: 81
< Cache-Control: max-age=86400
< Expires: Sun, 28 Jul 2024 05:09:59 GMT
< Connection: Keep-Alive
< Content-Type: text/html
< 
<html>
<meta http-equiv="refresh" content="0;url=http://www.baidu.com/">
</html>
* Connection #0 to host baidu.com left intact
```

* curl 可使用多个单字母选项，如，curl打开详细模式并进行HTTP重定向：
```bash
curl -vL  http://jd.com
curl http://jd.com -Lv
curl -v -L http://jd.com    三种方式效果一致

-L, --location
              (HTTP) If the server reports that the requested page has moved to a different location (indicated with a Location:
              header and a 3XX response code), this option makes curl redo the request on the new place.
```

### 使用curl详细模式(3.1)
```bash
curl -v --silent http://jd.com    ## --silent 静默模式 关闭进度指示器也可以 -s
* Host jd.com:80 was resolved.
* IPv6: (none)
* IPv4: 211.144.24.218, 211.144.27.126, 111.13.149.108  #域名解析DNS，找到对应的IP地址
*   Trying 211.144.24.218:80... #trying表示正在建立TCP连接
* Connected to jd.com (211.144.24.218) port 80  #connected表示已连接其中一个IP地址
> GET / HTTP/1.1        # >表示客户端请求，Line92-96 表示一个完整的HTTP请求
> Host: jd.com
> User-Agent: curl/8.6.0
> Accept: */*
>                       # 空行表示表头和正文之间的间隔，且该请求没有“正文”
< HTTP/1.1 301 Moved Permanently        # < 表示服务端响应。301或200表示运行良好
< Date: Sat, 27 Jul 2024 05:29:47 GMT
< Content-Type: text/html
< Content-Length: 178
< Connection: keep-alive
< Location: https://www.jd.com
< Server: jfe
< Cache-Control: no-cache
< 
<html>
……
```

* 应用：测试连通性
curl -v http://xxxx
如果一直显示trying，则表示无法连接；如果出现了connected，则说明连接成功
```bash
➜  notes git:(main) ✗ curl -v --silent http://jd.com:22    
* Host jd.com:22 was resolved.
* IPv6: (none)
* IPv4: 211.144.24.218, 111.13.149.108, 211.144.27.126
*   Trying 211.144.24.218:22...

* connect to 211.144.24.218 port 22 from 172.16.2.36 port 62744 failed: Operation timed out
*   Trying 111.13.149.108:22...
```

```bash
➜  notes git:(main) ✗ curl -v --silent http://jd.com --trace-time      #显示高精度的时间戳
13:48:09.985249 * Host jd.com:80 was resolved.
13:48:09.985651 * IPv6: (none)
13:48:09.985675 * IPv4: 106.39.171.134, 111.13.149.108, 211.144.27.126
13:48:09.985740 *   Trying 106.39.171.134:80...
```

### 用curl下载（3.3）
* 保存网页 curl -o 
```bash
curl -o output.html  http://shanbay.com -Ls
# -o filename 将网页保存并命名
# -L location 用于当请求网页内容已转移至新地址，不加-L时，服务器会通过location字段返回新地址；加-L，通过继续请求新地址，获得内容
# -s silent模式
```

* 保存网页上的图片
```bash
➜  notes git:(main) ✗ curl -O https://assets0.baydn.com/static/img/shanbay_favicon.png -s
➜  notes git:(main) ✗ open shanbay_favicon.png
# 保存网页上的图片，可用大写O （-O），省略保存本地的文件名，直接输入其网址
# open 是MAC电脑特有的命令，相当于双击（打开文件）；可以打开目录、文件、视频、网址、app等, 
    open http://shanbay.com #浏览器打开网页
    open . #打开当前目录
    open .. #打开上级目录
```

* curl只获取首部
```bash
curl -I/--head #Fetch the headers only! 
```
>学习和辅导 感悟，兴趣和引导最重要，学习快乐，快乐学习，不要负担！

```bash
df: 看到yy 学习笔记，才发现，初学计算机还是需要指导的，不然会浪费很多时间。
需要好老师备课和引导，而不是陷入晦涩难懂的理论。
初学更多是兴趣，引导， 这样才有深入的可能。
如果一上来就是那些理论公式，一是用处不大，二是打击积极性、害人啊。
快乐学习，学习快乐，不要负担！ 引导看书，先看易懂的，画出重点。
别人的推荐未必合适，一定要结合自己实际情况，去选择。 
如果看到不懂，就飞快掠过，等以后再看。
如果以后遇不到，也就不用看了！！ 书籍太多，一定要学会速览，学会提取自己感兴趣的，学会主题阅读法。
谨言慎行。说出来，沟通效率更高。
```

# Day 8 20240726 
 《计算机网络》 谢希仁
## Chapter 1
### 概念：
- 网络：若干节点（_node_）和链接这些节点的链路（link）组成。节点可以是计算机、集线器、交换机或路由器
- 互联网：网络和网络连接起来（network of networks），构成了覆盖范围更大的网络，即互联网
- 因特网：世界上最大的互联网络。连接在因特网上的计算机都被称为“主机”。

### 因特网的组成：
- 边缘部分：所有连接在因特网上的主机组成。这部分是用户直接使用，用来通信（传送数据、音频和视频）和资源共享
- 核心部分：大量网络和连接这些网络的路由器组成。这部分是为边缘部分提供服务的（提供连通性和交换）

#### 边缘部分（又称端系统-end system）
- 通信方式：客户/服务器方式 C/S client/server；对等方式 P2P peer/peer 
- C/S：客户运行程序 > 向服务器请求服务 > 服务器运行程序 > 向客户提供服务（客户得到服务）
    - 客户程序向服务器发起通信（请求服务）时，客户程序必须知道服务器程序的地址
    - 客户程序不需要特殊的硬件和复杂的操作系统
    - 服务器被动接受来自各地客户的通信请求，不需要知道客户程序的地址
    - 服务器一般需要强大的硬件和操作系统
    - 客户与服务器通信关系建立后，双方可以双向通信、互相发送和接受数据
- P2P：本质上仍是C/S，只是对等连接中每个主机都既是客户又是服务器

#### 核心部分
- 路由器：一种专用计算机（不是主机），是实现分组交换（packet switching）的关键构建，任务是转发收到的分组——网络核心部分最重要的功能
- 电路交换：通信资源被占用，效率低、浪费资源
- 分组交换：采用存储转发技术（将数据分成等长的块，一块一块的进行传输）
    - 整块数据：报文（message），应用层概念，完整的信息，由传输层交付
    - 必要的控制信息（类似分组依据？）：首部（header）或包头。非常重要，包含了目的地址和源地址等重要信息，分组能因此独立并正确地被交付
    - 数据传输单元：分组（packet），信息在网络中传输的单元，网络层实现分组交付，抓包工具抓到的内容
    区分主机和路由器：
    - 主机是为用户进行信息处理的，可以和其他主机通过网络交换信息（相当于寄快递是 寄件方和收件方）
    - 路由器则用来转发分组，进行分组交换的（相当于快递人员根据收件人信息进行送货）
    路由器暂时存储的是一个个短分组，而非整个长报文；短分组存在路由器的存储器（即内存）中，而不是磁盘中。（缺点：断电后存储器中的数据立即消失，用户端会出现‘发送失败’等类似的异常提示）
### 计算机网络常用的性能指标：
- 速率：比特（bit）是计算机中数据量的单位。速率最重要的性能指标。
- 带宽：bandwidth 一条通信链路的“带宽”越宽，所能传输的“最高数据率”也越高。
- 吞吐量： throughout 单位之间内通过某个网络（或信道、接口）的数据量
- 时延：delay或latency，指数据（一个报文或分组、甚至是比特）从网络（或链路）的一端传送到另一端所需的时间
    - 发送时延 transmission delay 主机或路由器发送数据帧所需的时间；发生在机器内部的发送器上
    - 传播时延 propagation delay 信道中传播一定距离花的时间； 发生在传输信道媒体上
    - 处理时延 如分析分组的首部、差错检验或者查找适当路由等的时间
    - 排队时延
- 时延带宽积 = 传播时延（长度）*带宽（截面）= 管道体积，表示链路可容纳多少比特。
- 往返时间 RTT（Round-Trip Time），从发送到接收接收方的确认信息总共经历的时间
- 信道（网络）利用率：信道利用率指某信道有百分之几的时间是被利用（有数据通过的）；网络利用率是全网螺信道利用率的加权平均值

### 网络协议
#### 网络协议主要由三个要素组成
- 语法，数据与控制信息的结构或格式
- 语义，需要发出何种控制信息，完成何种动作以及作出何种响应
- 同步，事件实现顺序的详细说明

#### 五层协议划分
- 应用层：application layer
- 运输层：transport layer 最重要的协议是传输控制协议TCP、用户数据报协议UDP
- 网络层（网际层）：network layer 最重要的协议IP
- 数据链路层：data link layer
- 物理层：physical layer

## Chapter 2 物理层  #重点是掌握基本概念
### 物理层的主要任务  
* 确定与传输媒体的接口有关的一些特性  
    - 机械特性 形状、尺寸、数量排列等  
    - 电气特性 各条线上的电压范围  
    - 功能特性 指明某条线上出现的某一电平的电压表示何种意义  
    - 过程特性

### 数据通信基本知识
* 数据通信系统可划分为三大部分：
    - 源系统（发送端、发送方）
        - **源点** source 产生要传输的数据
        - **发送器** 典型的发送器是调制器
    - 传输系统 传输网络
    - 目的系统（接收端、接收方）
        - **接收器**典型的是解调器，把模拟信号解调，提取发送端置入的消息
        - **终点** destination 输出信息，也称目的站、信宿
* 通信的目的是传送消息 message，如话音、文字、图像、视频等都是消息
* 数据data是运送消息的实体，通常是有意义的符号序列；信号signal是数据的电器或电磁的表现。信号可分为两类：
    - 模拟信号，或连续信号：代表消息的参数的取值是连续的 
    - 数字信号，或离散信号：代表消息的参数的取值是离散的 

### 关于信道的几个概念：
- 信道不等于电路，信道一般用来表示某一个方向传送信息的媒体；因此，一条电路往往包含一条发送信道+一条接收信道
- 来自信源的信号常称为基带信号，多包含低频成分，而信道无法传输，故需要对基带信号进行调制（modulation）
- 调制Modulation分为两类：
    1. 仅变换基带信号的波形，变换后仍是基带信号，称之为基带调制，或编码 coding
    2. 用载波carrier调制，把基带信号的频率范围搬移到较高的频段，并转换为模拟信号。调制后成为带通信号

- 常用的编码方式：
    1. 不归零：正电平1 负电平0
    2. 归零：正脉冲1，负脉冲0
    3. 曼彻斯特编码：向上跳0，向下跳1
    4. 差分曼彻斯特：位开始有跳变0，反之1

### 限制码元在信道上的传输速度的因素
- 信道能够通过的频率范围
- 信噪比：信号的平均功率和噪声的平均功率之比，S/N 
信噪比越高，信息的传输速率就越高

### 物理层面下的传输媒体
* 导引型传输媒体
    * 双绞线：互相绝缘的铜导线；常见电话线；可加抗干扰屏蔽层
    绞合线类别，一般数字越大带宽越大
    * 同轴电缆：绝缘保护套层、外导体屏蔽层、绝缘层和内导体构成；良好的抗干扰性
    * 光纤：传输带宽远大于其他传输媒体；低损耗，发展迅速

* 非导引型 无线传输  
    红外通信、激光通信，可用于近距离的笔记本电脑相互传输数据

### 信道复用技术
- 频分复用 FDM Frequency Division Multiplexing
- 时分复用 TDM Time Division Multiplexing：用户在每个TDM帧中占固定序号的时隙。也称 isochronous signal
- 波分复用 WDM Wavelength Division Multiplexing
- 码分复用 CDM Code Division Multiplexing 常称为：码分多址 CDMA Code Division Multiple Access

### 数字传输系统
光纤-长途干线最主要的传输媒体，适用于高速率数据业务（如视频会议）和大量复用的低速率业务

### ADSL技术 Asymmetric Digital SUbscriber Line
* 非对称数字用户线技术：用数字技术对现有的模拟电话用户线改造（优点：不需要重新布线）  
    * 0～4kHz 的低频谱留给传统电话；高端频谱用于上网
    * ADSL的下行（从ISP到用户）带宽远大于上行（用户到ISP），所以非对称；不适合企业
    * ADSL 传输距离取决于数据率和用户线的线径（线越细，信号衰减越大）

# Day 7 20240725

《UNIX/LINUX/OS X中的Shell编程》 人民邮电出版社

## Chapter 2 什么是Shell
- 内核和实用工具：Unix系统在逻辑上被划分为**内核**和**实用工具（Utility）**，通常来说，所有的访问都要经过**Shell**。  
- 内核是Unix系统的核心所在，内核位于计算机的内存中；组成Unix的各种实用工具位于计算机磁盘中，需要的时候会被加载到内存并执行。

### Shell的功能
1. 程序执行：Shell负责执行终端中指定的所有程序。  
- 每次输入一行内容（正式名称：命令行），Shell会扫描命令行，确定要执行的程序名称及所传入的程序参数。  
- Shell会使用一些特殊字符确定程序名称及每个参数的起止，这些字符统称为空白字符（whitespace characters），包括空格符、水平制表符和行尾符（又叫换行符）。连续多个空白会被Shell忽略。

```bash
mv tmp/mazewars games 
#Shell会扫描该命令行，提取到行首到 第一个空白字符之间的所有命令作为待执行的程序名称：mv。随后的空白字符（多余的空格）会被忽略。
#第一、二个空白字符之间的字符，作为mv的第一个参数 tmp/mazewars
#games 是第二个参数
```
2. 变量及文件名替换:
Shell 分析命令行 “echo *”时，识别出了特殊字符星号，将其替换成了目录下所有的文件名。
```bash
bash-3.2$ ls
ls_no_usr.txt   ls_usr.txt      notes           sayHello.sh     testhello.txt   uniq.txt
bash-3.2$ echo *
ls_no_usr.txt ls_usr.txt notes sayHello.sh testhello.txt uniq.txt
```

3. I/O重定向
重定向字符：> < >>  <<
```bash
bash-3.2$ ls
ls_no_usr.txt   ls_usr.txt      notes           sayHello.sh     testhello.txt   uniq.txt
bash-3.2$ cat uniq.txt
abc
123
abc
123
bash-3.2$ echo Remeber to learn Shell > uniq.txt  #将内容写到已有的文件中
bash-3.2$ cat uniq.txt
Remeber to learn Shell  #原有的文件内容被覆盖
bash-3.2$ echo Remeber to learn Shell > uniq2.txt   #将内容写到不存在的文件中
bash-3.2$ cat uniq2.txt
Remeber to learn Shell      #内容被写入了该文件（与书上讲的不一致，书上讲Shell会报错）
bash-3.2$ ls
ls_no_usr.txt   ls_usr.txt      notes           sayHello.sh     testhello.txt   uniq.txt        uniq2.txt
# 该文件被自动创建
```
```bash
bash-3.2$ wc -l uniq2.txt  #Shell先读取wc命令，第一个参数是 -l，要统计行数；第二个参数指定了待统计的文件
       1 uniq2.txt      #因此输出了打印结果和待统计文件的文件名
bash-3.2$ wc -l < uniq2.txt #与上条不同，Shell扫描时发现了重定向字符<, 其后的单词被解释成了从中重定向输入的文件名（可以理解为文件内容被Shell读取了？），然后Shell开始执行wc程序，并将标准输入重定向为文件uniq2.txt、并传入单个参数-l。
       1    #wc统计行数的时候，只知内容，不知是何文件的内容，所以只输出了行数，没有文件名。

#待定：是否可以理解为，重定向优先级高于命令和参数？yes
```

4. 管道
Shell扫描命令行时，除了重定向符号，还会查找管道字符|。每找到一个，就会将之前命令的标准输出连接到之后命令的标准输入，然后执行这两个命令。
```bash
bash-3.2$ who
cyy              console       7  3 22:17 
bash-3.2$ who | wc -l  #who的标准输出连接到了wc -l的标准输入
       1
```

5. 环境控制（Chapter 10展开）
6. 解释型编程语言
- Shell有自己内建的编程语言，这种语言是解释型的，即Shell会分析所遇到的每一条语句，然后执行所发现的有效的命令。
- 与C++及Swift不同，这些语言中，程序语句在执行之前会被编译成可由机器执行的形式
- 解释型语言一般更易于调试和修改，但耗时较长


## Chapter 3 常备工具

### 正则表达式 （）
与Shell只能在文件名替换中识别部分正则表达式。 两者区别？
* 点号`.`：匹配任意单个字符
```bash
r. #可以匹配r及任意单个字符
.x. #可以匹配任意两个字符包围的x，这两个字符不必相同
```

```bash
#创建名为edintro的文件，并添加内容如下：
The Unix operating system was pioneered by Ken
Thompson and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
environment that promoted efficient program
development

bash-3.2$ ed edintro    #输入ed指令
newline appended        #输出结果
239                     #输出结果 字符数
1,$p                    #输入打印所有行指令：1,$指 第一行至末行；p指 打印
The Unix operating system was pioneered by Ken
Thompson and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
environment that promoted efficient program
development

/ .. /      #查找由空格包围的2个字符（2个字母的单词）
The Unix operating system was pioneered by Ken
/           #重复上一个操作，会逐行输出
Thompson and Dennis at Bell Laboratories
/
in the late 1960s. One of the primary goals in
/
the design of the Unix system was to create an 
/
The Unix operating system was pioneered by Ken #全文搜索完成后，会返回到第一行
##存在问题：如何一次性打印出所有符合要求的结果？

1,$s/p.o/XXX/g          #将所有的“p.o”替换成“XXX”，s表示替换，g表示所有
1,$p                    #查看修改结果               
The Unix operating system was XXXneered by Ken
ThomXXXn and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
environment that XXXmoted efficient XXXgram

##存在的问题：修改结果不可逆；不加g的时候不是每行都替换，很奇怪
```

* 脱字符`^`：匹配行首
如果脱字符作为正则表达式的第一个字符，它可以匹配行首位置。如：
```bash
^George  # 只能匹配出现在行首的George
```
因此，正则表达式中被称为“左根部（left-rooting）”

```bash
bash-3.2$ ed lred
newline appended
239
/the/       #查找the
in the late 1960s. One of the primary goals in
/           #继续查找the
the design of the Unix system was to create an 
/^the/      #查找位于行首的the
the design of the Unix system was to create an


>>The Unix operating system was pioneered by Ken
>>Thompson and Dennis at Bell Laboratories
>>in the late 1960s. One of the primary goals in
>>the design of the Unix system was to create an 
>>environment that promoted efficient program
>>development
1,$s/>>/^/g             #把所有的>>替换成^
1,$p
^The Unix operating system was pioneered by Ken
^Thompson and Dennis at Bell Laboratories
^in the late 1960s. One of the primary goals in
^the design of the Unix system was to create an 
^environment that promoted efficient program
^development
```

* 美元符号`$`：匹配行尾
```bash
contents$   #可匹配位于行尾的contents
.$          #可匹配行尾的任意字符
\.$         #可匹配位于行尾的点号
^\.         #可匹配点号开头的行
```

```bash
#原文
The Unix operating system was pioneered by Ken
Thompson and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
environment that promoted efficient program
development.

bash-3.2$ ed dollared
newline appended
240
//.$/       #转义是反斜杠
?
/\.$/       #输出以点号结尾的行
development.

bash-3.2$ ed dollared
newline appended
240
1,$s/$/>>/g     #每行行尾加上>>
1,$p            #全部打印
The Unix operating system was pioneered by Ken>>
Thompson and Dennis at Bell Laboratories>>
in the late 1960s. One of the primary goals in>>
the design of the Unix system was to create an >>
environment that promoted efficient program>>
development.>>

1,$s/..$//      #删除每行最后的2个字符（空格替换）
1,$p
The Unix operating system was pioneered by Ken
Thompson and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
environment that promoted efficient program
development.
```
`^`和`$`组合使用：
```bash
^$ #匹配空行
^ $ #匹配单个空格组成的行
```

* 英文省略号`[...]`：匹配字符组
```bash
[0-9]   #匹配0-9之间的任意数字
[A-Z]   #匹配大写字母
[A-Za-z]    #匹配大写和小写字母
[^A-Z]      #匹配大写字母以外的任意字符 相当于Shell中的感叹号！
```

* 星号`*`：匹配零个或多个字符
正则表达式中，星号用于匹配零次或多次出现在其之前的正则表达式元素，因此：
```bash
X*      #可以匹配0个或多个大写字母X
XX*     #可以匹配1个或多个大写字母X
X+      #同等替换XX*

```bash
#原文
This             is      an   example
of a     file     that 
contains

bash-3.2$ ed starblank
newline appended
71
1,$s/  */ /g        #将2个及以上的空格替换成1个个空格
1,$p
This is an example
of a file that 
contains
```

```bash
#原文
The Unix operating system was pioneered by Ken
Thompson and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
environment that promoted efficient program
development

bash-3.2$ ed ed
newline appended
239
1,$s/e.*e/+++/g     #将每行中e开始与结束之间的部分，替换成+++
1,$p
Th+++n              #e Unix operating system was pioneered by Ke 被替换
Thompson and D+++s  #ennis at Bell Laboratorie 被替换
in th+++ primary goals in   #e late 1960s. One of the 被替换，注意：并不会因为遇到了e就停止，而是会替换直至最后一个
th+++ an #esign of the Unix system was to create被替换
+++nt program
d+++nt


bash-3.2$ ed ed
newline appended
239

1,$s/^e.*/+++/      #将e为行首的单词替换成+++
1,$p
The Unix operating system was pioneered by Ken
Thompson and Dennis at Bell Laboratories
in the late 1960s. One of the primary goals in
the design of the Unix system was to create an 
+++ #仅environment被替换
development

1,$s/.*n//g     #将每行中 字母n及其以前的内容删除
1,$p

is at Bell Laboratories


+++
t
```

```bash
#原文
- :

1,$s/:-//g      #如果想匹配连接符，不可直接在斜杠里
?
1,$s/[-]//g     #匹配连接符，需要加中括号
1p
 :

类似的，[]a-z] 表示匹配又中括号或小写字母
```

* `\{...\}`：匹配固定次数的子模式
```bash
\{min,max\}  #min指待匹配的正则表达式需要出现的最小次数，max则为最大次数；且必须用\对花括号进行转义

X\{1,10\}    #指能匹配1-10个连续的X
[A-Za-z]\{4,7\} #匹配4-7之间的字母字符序列

\{10\}  #花括号之间只有一个数字，表示正则表达式必须匹配的次数
[a-zA-Z]\{7\}       #能够匹配7个字母字符

.\{10\}     #能够匹配10个任意字符

+\{5,\}     #花括号单个数字紧跟一个逗号，表示至少匹配5次，最多不限。 此处指匹配至少5个连续的+
```


# Day 6 20240724 

Linux 脚本学习（自学版）

## while循环
### 结构
```bash
while expression
do
    command
done
```

已知循环次数，可以用计数的方式控制循环，即设定一个计数器，在达到规定的循环次数后退出循环：
```bash
#! /bin/bash
CONTER=5   #定义计数器，循环次数为5
while [[ $CONTER -gt 0 ]]  #测试CONTER大于0的情况下继续循环，注意两个中括号之间无空格，里面的中括号与expression之间有空格
do
    echo -n "$CONTER"
    let "CONTER-=1" #每次循环，CONTER=CONTER-1
done
echo
```

练习题：  
* 用while循环计算1-100之和、1-100奇数之和
```bash
#! /bash/bin
#sum01计算1-100的和
#sum02计算1-100奇数的和
sum01=0
sum02=0
i=1
j=1
while [[ "$i" -le "100" ]]
do
    let "sum01+=i"
    let "j=i%2"     #变量j用来确定变量i的奇偶行，如果是奇数则余为1
    if [[ $j -ne 0 ]]; then #j不等于0，则表示只取奇数
        let "sum02+=i"
    fi
    let "i+=1"  #一次次循环
done
echo "sum01=$sum01"
echo "sum02=$sum02"
```

* 用while做猜数字游戏，只有输入的数字和预设数字一致时，才会停止循环：
```bash
#! /bin/bash
PRE_SET_NUM=8
echo "Input a number between 1 and 10"
while  read GUESS
do
    if [[ "$GUESS" -eq "$PRE_SET_NUM" ]]; then #书上格式有误，引用数据需加双引号，否则会报错
        echo "You get the right number"
        exit
    else
        echo "Wrong, try again"
    fi
done
```

### while 结合 awk 
按行读取文件，输出信息，两种方式：
```bash
#创建文件
John 30 Boy
Sue 28 Girl
Wang 25 Boy 
Xu 23 Girl
```
1. 重定向
```bash
#! /bin/bash
while  read LINE
do
    NAME=`echo $LINE | awk '{print $1}'`
    AGE=`echo $LINE | awk '{print $2}'`
    SEX=`echo $LINE | awk '{print $3}'`
    echo "My name is $NAME, I'm $AGE years old, I'm a $SEX"
done < student_info.txt
```
2. 管道
```bash
#! /bin/bash
cat student_info.txt | while read LINE
do
    NAME=`echo $LINE | awk '{print $1}'`
    AGE=`echo $LINE | awk '{print $2}'`
    SEX=`echo $LINE | awk '{print $3}'`
    echo "My name is $NAME, I'm $AGE years old, I'm a $SEX"
done
```

## until循环
## 结构
until是测试假值的方式（与while相对），直到测试为真时才停止循环，其语法结构与while一致：
```bash
until expression
do
    command
done
```

练习：  
* 计算1-100之和、1-100奇数之和：
```bash
#! /bash/bin
#sum01计算1-100的和
#sum02计算1-100奇数的和
sum01=0
sum02=0
i=1
j=1
until [[ "$i" -gt "100" ]] #仅此一行与while语句不同
do
    let "sum01+=i"
    let "j=i%2"     #变量j用来确定变量i的奇偶行，如果是奇数则余为1
    if [[ $j -ne 0 ]]; then #j不等于0，则表示只取奇数
        let "sum02+=i"
    fi
    let "i+=1"  #一次次循环
done
echo "sum01=$sum01"
echo "sum02=$sum02"
```

## case 判断结构
### 结构
和if/elif/else结构一样，case判断结构也可以用于多种可能情况下的分支选择，其语法结构如下：
```bash
case VAR in
var1) command 1 ;;
var2) command 2 ;;
var3) command 3 ;;
...
*) command ;;
esac
```

## select循环
程序运行到select语句时，会自动将列表中的所有元素生成为可用1、2、3等数选择的列表，并等待用户输入。用户输入并回车后，select看判断输入并执行后续命令。
结合case使用，有判断用户输入的功能：
```bash
#! /bin/bash
select FRUIT in apple banana pear
do
    case $FRUIT in 
    apple) echo "I like apple best" ;;
    banana) echo "I like banana best" ;;
    pear) echo "I like pear best" ;;
    *) echo "I don't like these fruit" ;;
    esac
done

#运行结果
➜  ~ bash case.txt
1) apple
2) banana
3) pear
#? 2
I like banana best
#? 3
I like pear best
#? 5
I don't like these fruit
#? 
```

## 嵌套循环
一般不超过3个
用for和while呈现九九乘法表
```bash
#! /bin/bash
for ((i=1; i<=9; i++))
do
    for ((j=1; j<=9; j++))
    do
        let "multi=$i*$j"
        echo -n "$i*$j=$multi"
    done
    echo
done

i=1
while [[ "$i" -le "9" ]]
do
    j=1
    while [[ "$j" -le "9" ]]
    do
        let "multi=$i*$j"
        echo -n "$i*$j=$multi"
        let "j+=1"
    done
    echo
    let "i+=1"
done

#输出结果
1*1=11*2=21*3=31*4=41*5=51*6=61*7=71*8=81*9=9
2*1=22*2=42*3=62*4=82*5=102*6=122*7=142*8=162*9=18
3*1=33*2=63*3=93*4=123*5=153*6=183*7=213*8=243*9=27
4*1=44*2=84*3=124*4=164*5=204*6=244*7=284*8=324*9=36
5*1=55*2=105*3=155*4=205*5=255*6=305*7=355*8=405*9=45
6*1=66*2=126*3=186*4=246*5=306*6=366*7=426*8=486*9=54
7*1=77*2=147*3=217*4=287*5=357*6=427*7=497*8=567*9=63
8*1=88*2=168*3=248*4=328*5=408*6=488*7=568*8=648*9=72
9*1=99*2=189*3=279*4=369*5=459*6=549*7=639*8=729*9=81

```

## 循环控制
### break语句
break用于终止当前整个循环体，一般break语句会与if判断语句一起使用，当if条件满足时用break终止循环。
上述九九乘法表存在问题：有一半时重复的，可以用break优化：
```bash
#! /bin/bash
for ((i=1; i<=9; i++))
do
    for ((j=1; j<=9; j++))
    do
        if [[ $j -le $i ]];then        #if后有空格，then前面没有空格
            let "multi=$i*$j"
            echo -n "$i*$j=$multi"
        else
            break    
        fi
    done
    echo
done

i=1
while [[ "$i" -le "9" ]]
do
    j=1
    while [[ "$j" -le "9" ]]
    do
        if [[ $j -le $i ]];then        #if后有空格，then前面没有空格
            let "multi=$i*$j"
            echo -n "$i*$j=$multi"
            let "j+=1"
        else
            break    
        fi
    done
    echo
    let "i+=1"
done
```

## 重定向
### 标准输出覆盖重定向：> 覆盖
```bash
➜  g cat ls_no_usr.txt 
total 16
-rw-r--r--   1 cyy  staff    0  7 24 12:56 ls_no_usr.txt
-rw-r--r--   1 cyy  staff  163  7 24 12:52 ls_usr.txt
drwxr-xr-x  23 cyy  staff  736  7 24 11:42 notes
-rw-r--r--   1 cyy  staff   16  7 24 10:49 uniq.txt
let's see what happens%                                                                                    
➜  g ls -l /Users/cyy/g> ls_no_usr.txt
➜  g cat ls_no_usr.txt                
total 16
-rw-r--r--   1 cyy  staff    0  7 24 12:57 ls_no_usr.txt
-rw-r--r--   1 cyy  staff  163  7 24 12:52 ls_usr.txt
drwxr-xr-x  23 cyy  staff  736  7 24 11:42 notes
-rw-r--r--   1 cyy  staff   16  7 24 10:49 uniq.txt
```
### 标准输出追加定向：>> 追加
```bash
➜  g cat ls_no_usr.txt                
total 16
-rw-r--r--   1 cyy  staff    0  7 24 12:57 ls_no_usr.txt
-rw-r--r--   1 cyy  staff  163  7 24 12:52 ls_usr.txt
drwxr-xr-x  23 cyy  staff  736  7 24 11:42 notes
-rw-r--r--   1 cyy  staff   16  7 24 10:49 uniq.txt
➜  g ls -l /Users/cyy/g>> ls_no_usr.txt 
➜  g cat ls_no_usr.txt                 
total 16
-rw-r--r--   1 cyy  staff    0  7 24 12:57 ls_no_usr.txt
-rw-r--r--   1 cyy  staff  163  7 24 12:52 ls_usr.txt
drwxr-xr-x  23 cyy  staff  736  7 24 11:42 notes
-rw-r--r--   1 cyy  staff   16  7 24 10:49 uniq.txt
>> 标准输出追加定向total 24
-rw-r--r--   1 cyy  staff  248  7 24 12:59 ls_no_usr.txt
-rw-r--r--   1 cyy  staff  163  7 24 12:52 ls_usr.txt
drwxr-xr-x  23 cyy  staff  736  7 24 11:42 notes
-rw-r--r--   1 cyy  staff   16  7 24 10:49 uniq.txt
```
### 标识输出重定向：>& 没看明白
### 标准输入重定向：<
标准输入重定向可以将原本应由从标准输入设备中读取的内容转由文件内容舒服，也就是将文件内容写入标准输入中。
```bash
➜  g cat   #先输入cat命令
Hello   #键盘输入Hello，按回车
Hello   #cat命令读取并输出Hello
World   #键盘输入World
World   #cat命令读取并输出World
[Ctrl+D] 终止输入
```
sort 重定向排序  #好像没啥区别？
```bash
➜  g sort sort.txt
carrot
durian
eggplant
orange
pear
➜  g sort < sort.txt
carrot
durian
eggplant
orange
pear
```

## 函数
### 函数定义和调用：
```bash
#shell中的函数定义
#function为关键字，FUNCTION_NAME为函数名
function FUNCTION_NAME(){
    command1 #函数体 可以有多个语句，不允许有空格
    command2
    …
}       函数定义结束

#另一种形式，省略关键字 function，效果一致：
FUNCTION_NAME(){
       command1 #函数体 可以有多个语句，不允许有空格
    command2
    …
}  
```
函数定义和调用示例：
```bash
#! /bin/bash
function sayHello(){        #定义函数say Hello
    echo "Hello"            #该函数的函数体为打印Hello
}                           #函数定义结束
echo "Call function sayHello"   #提示函数调用
sayHello                        #函数调用

#脚本运行结果
➜  g bash sayHello.sh
Call function sayHello
Hello
```

## 《UNIX/LINUX/OS X中的Shell编程》 人民邮电出版社 开始学习
### Chapter 1 基础概述
- date命令：显示日期和时间
```bash
➜  ~ date
2024年 7月24日 星期三 15时33分35秒 CST
```
- who命令：找出已登录人员
```bash
➜  ~ who
cyy              console       7  3 22:17 

#也可以获取本人信息
➜  ~ who am i
cyy                            7 24 15:35 
```
- echo命令：回显字符
echo命令会在终端打印出（或者回显）在行中输入的所有内容
```bash
➜  ~ echo this is a test
this is a test
➜  ~ echo why not print out a longer line with echo? 
zsh: no matches found: echo?
➜  ~ echo "why not print out a longer line with echo?"
why not print out a longer line with echo?
➜  ~ echo one    two      three four
one two three four
```
- ls命令：查看目录下的文件
- cat命令：检查文件内容 concatenate
```bash
➜  notes git:(main) ✗ cat forlist.sh
#! /bash/bin
for VAR in {1..5}
do
    echo "Loop $VAR times"
done%  
```
- wc命令：统计文件中单词数量
wc命令可以获得文件中的行数、单词数和字符数
```bash
➜  g cat ls_usr.txt
total 8
-rw-r--r--   1 cyy  staff    0  7 24 12:52 ls_usr.txt
drwxr-xr-x  23 cyy  staff  736  7 24 11:42 notes
-rw-r--r--   1 cyy  staff   16  7 24 10:49 uniq.txt
➜  g wc ls_usr.txt
       4      29     163 ls_usr.txt
```
- 命令选项 -，后面直接跟字母
如要计算文件中包含的行数，可以用“wc -l”; 字符数可以用 -c选项；单词数 -w选项
```bash
➜  g wc -l ls_usr.txt  #-l选项 行数
       4 ls_usr.txt
➜  g wc -c ls_usr.txt  #-c选项 字符数
     163 ls_usr.txt
➜  g wc -w ls_usr.txt  #-w选项 单词数
      29 ls_usr.txt
```

- cp命令：复制文件
```bash
cp names saved_names  #names表示源文件，saved_names表示目标文件
```
```bash
➜  g ls
ls_no_usr.txt ls_usr.txt    notes         sayHello.sh   sort.txt      testhello.txt uniq.txt
➜  g cp sort.txt sortcp.txt
➜  g ls
ls_no_usr.txt notes         sort.txt      testhello.txt
ls_usr.txt    sayHello.sh   sortcp.txt    uniq.txt
```
- mv命令：文件重命名/移动
    1. 重命名
```bash
mv old_name new_name

➜  g ls
ls_no_usr.txt ls_usr.txt    notes         sayHello.sh   sort.txt      testhello.txt uniq.txt
➜  g mv sort.txt sortmv.txt
➜  g ls
ls_no_usr.txt notes         sortcp.txt    testhello.txt
ls_usr.txt    sayHello.sh   sortmv.txt    uniq.txt
```
  
    2. 移动
        mv oldNamefile newNamefile 移动 #移动没搞懂 解答 ../上级目录，./同级目录
```bash
➜  g mv sortmv.txt ./notes
➜  g ls
ls_no_usr.txt ls_usr.txt    notes         sayHello.sh   testhello.txt uniq.txt
➜  g cd notes
➜  notes git:(main) ✗ ls
0720-tmp-files   elifscore.sh     ifcheckfile.sh   learnwhile.sh    test2.md         while03.sh
HelloWorld.sh    forlist.sh       ifscore.sh       quiz.sh          until01.sh
IELTS.md         forlist03.sh     learnfor.sh      sortmv.txt       while01.sh
README.md        fruit01.sh       learnif.sh       student_info.txt while02.sh
```

* rm命令：删除文件
```bash
rm names

#rm也可以一次性删除多个文件，空格隔开即可
```


* mkdir命令：创建目录
* 目录之间复制(cp)、移动（mv）文件
```bash
cp oldd/name1 newd/name2 
#同级目录格式

#因为在不同目录中，名字可以相同，此时可以仅指定目录：
cp oldd/name1 newd
```
* ln命令：文件链接
创建链接，可以克服cp 占2倍磁盘空间、只改了一处另一处忘记改的风险问题
```bash
➜  g2 ls
456       789       899       mv202.doc
➜  g2 ln mv202.doc mv203.doc
➜  g2 ls
456       789       899       mv202.doc mv203.doc
➜  g2 cat mv202.doc
➜  g2 code mv202.doc
➜  g2 cat mv202.doc 
test  ln %                                                                                                 
➜  g2 cat mv203.doc
test  ln %
#执行ls命令时，会显示两个独立的文件
➜  g2 ls -l          
total 16
drwxr-xr-x  2 cyy  staff  64  7 20 14:48 456
drwxr-xr-x  3 cyy  staff  96  7 20 14:49 789
drwxr-xr-x  3 cyy  staff  96  7 20 14:53 899
-rw-r--r--  2 cyy  staff  42  7 24 16:40 mv202.doc
-rw-r--r--  2 cyy  staff  42  7 24 16:40 mv203.doc
-rw-r--r--  1 cyy  staff   0  7 24 16:42 test2.txt
#第二列显示2，表示文件的连接数，没有链接的非目录文件显示1（test2.txt）
#两个链接文件可以任意删一个，另一个不会随之消失，删除后第2列会显示1
```

* rmdir命令：删除目录 有危险不用
* 文件名替换 星号`*`
星号可以匹配当前目录下 所有 的文件名
```bash
#如果用cat，则会显示所有的文件内容
➜  star cat *
chapt 1 content testcontent test2content test3content4%
#如果用echo，则会显示当前目录下的所有文件
➜  star echo *
chapt1 chapt2 chapt3 chapt4
#也可以只显示出以chapt开头的文件内容和文件：
➜  star cat chapt*
chapt 1 content testcontent test2content test3content4%                                                    
➜  star echo chapt*
chapt1 chapt2 chapt3 chapt4
#不仅限于最后一个文件名，可以是文件名的任意位置
➜  star echo ch*pt1
chapt1
```
* 匹配单个字符
星号：可以匹配0个或多个字符，也就是x*，可以匹配文件x、x1、xabc
问号：仅能匹配单个字符
```bash
star02 ls
➜  star02 touch a aa aax alice b bb c cc report1 report2 report3
➜  star02 ls
a       aa      aax     alice   b       bb      c       cc      report1 report2 report3
➜  star02 echo ? 
a b c
➜  star02 echo ??
aa bb cc
➜  star02 echo a?
aa
➜  star02 echo ?*
a aa aax alice b bb c cc report1 report2 report3
➜  star02 echo ???*
aax alice report1 report2 report3
```

除问号，另一种匹配单个字符的方式：中括号给出待匹配的字符列表
```bash
➜  star02 echo [br]*   #匹配以b或r开头的所有文件
b bb report1 report2 report3

➜  star02 echo *[0-9] #匹配以数字结尾的所有文件
report1 report2 report3

➜  star02 echo [!br]* #匹配非b或r开头的文件，不work
zsh: event not found: br]
```
* 空格问题
如果文件名中有空格，直接cat+文件名会报错，2种解决方式：
```bash
➜  star02 cat my test document 
cat: my: No such file or directory
cat: test: No such file or directory
cat: document: No such file or directory
➜  star02 cat my\ test\ document   #将空格转义
➜  star02 cat "my test document"   #文件名加引号，单双都可以
➜  star02 cat 'my test document'
```
* 标准输入
sort 排序不work  #待修正

## Install ohmyzsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Enter bash
```bash
cyy@192 ~ % bash
bash-3.2$ VAR04="A        B        C"
bash-3.2$ echo $VAR04
A B C
bash-3.2$ echo $SHELL
/bin/zsh
```

# Day 5 20240723 
Linux 脚本学习（自学版）
## 变量：
### 变量命名
Shell中的变量必须以字母或下划线开头，后面可以跟数字、字母或下划线，变量长度没有限制。但要注意以下两类错误类型：  
1. PS1 #变量不能和Shell的预设变量名重名  
2. for #变量不能使用Shell的关键字

### 定义变量：变量名=变量值
- 注意1: 变量名和变量值之间用等号）
```bash
cyy@mac %  name=john
cyy@mac % name = john
zsh: command not found: name
cyy@mac % name= jonh
zsh: command not found: jonh

cyy@mac % name='john'
cyy@mac % name="john"
```
- 注意2: 变量值如果有空格，必须加引号，否则会报错
```bash
cyy@mac % name=john wang
zsh: command not found: wang

cyy@mac % name='john wang'
```

变量的取值：变量名前加上`$`符号，严谨一点的写法是`${}` 

```bash
cyy@mac % echo $name
john wang
cyy@mac % echo ${name}
john wang
```

区分以下两种赋值：若要打印“sue Hello”，变量需按标准格式➕{},如果没有，Shell语法自动将等号后的内容解释为变量（sue Hello），又因“sue Hello”并未声明，所以值为空

```bash
cyy@mac % name='sue '
cyy@mac % echo $nameHello

cyy@mac % echo ${name}Hello
sue Hello
```

由以上可知，Shell具有“弱变量性”，即在没有预先声明变量的时候也可以引用，且没有任何报错或者提醒，可能会造成脚本中引用不正确的变量，从而导致脚本异常但很难找出原因。在这种情况下，可以设置脚本运行时必须遵循“先声明再使用”的原则，这样一旦脚本中出现未声明的变量情况则会立刻报错：
```bash
cyy@mac % shopt -s -o nounset
zsh: command not found: shopt   ##问题
```

### 取消变量：unset
```bash
cyy@mac % name=john
cyy@mac % echo $name
john
cyy@mac % unset name
cyy@mac % echo $name
```

## 数组（Array）
定义数组：用declare定义数组Array, 第一个元素赋值为0，第二个为1，第三个元素：一个字符串 ##问题

数组可以在创建的同时赋值,增加/替换 ## 跟书上不一样呢？
```bash
cyy@mac % declare Score=('50' '70' '90')
cyy@mac % Score[2]='60'
cyy@mac % declare Score
Score=( 50 60 90 )
cyy@mac % declare Score=('50' '90')     
cyy@mac % Score[3]='100'
cyy@mac % declare Score            
Score=( 50 90 100 )
cyy@mac % Score[3]=('100' '120')
cyy@mac % declare Score         
Score=( 50 90 100 120 )
cyy@mac % Score[1]=('30' '40')  
cyy@mac % declare Score       
Score=( 30 40 90 100 120 )
```

## 引用
Shell中共有4种引用符，分别是双引号（部分引用或弱引用）、单引号（全引用或强引用）、反引号（将括起的内容解释为系统命令）、转义符（\）

部分引用：$、反引号（`）、转义符（\）依然会被解析为特殊意义
声明变量VARO3，第一次直接打印，第二次加双引号，输出没有区别
```bash
cyy@mac % VAR03=100
cyy@mac % echo $VAR03
100
cyy@mac % echo "$VAR03"
100
```
声明变量VAR04，加双引号与否，输出也没区别(与书上讲的不同)
```bash
cyy@mac % VAR04="A        B        C"
cyy@mac % echo "$VAR04"              
A        B        C
cyy@mac % echo $VAR04                
A        B        C
```

全引用：单引号中的任何字符都只当作是普通字符（除单引号本身，即单引号中间无法再单独包含单引号，用转义符也不可）。单引号中的字符只能代表其作为字符的字面意义：
```bash
cyy@mac % echo "$VAR03"
100
cyy@mac % echo '$VAR03'
$VAR03
```
如果全引用括起的字符串含有单引号，则会出现问题，需加转义符，或变单引号为双引号：
```bash
cyy@mac % echo 'It's a dog'   
quote> echo "It's a dog"     #quote啥意思
```

## 命令替换：1. `命令` 2. $(命令)
```bash
cyy@mac % DATE_01=`date`
cyy@mac % DATE_02=$(date)
cyy@mac % echo $ DATE_01  # $与命令间没有空格
$ DATE_01
cyy@mac % echo $DATE_01 
2024年 7月23日 星期二 13时47分47秒 CST
cyy@mac % echo $DATE_02
2024年 7月23日 星期二 13时48分03秒 CST
```

反引号可与`$()` 等价，因反引号与单引号看起来类似，时常对差看代码造成困难，所以使用`$()`就相对清晰：
```bash
cyy@mac % LS=`ls -l`
cyy@mac % echo $LS
total 96
drwxr-xr-x  12 cyy  staff    384  7 20 23:19 0720-tmp-files
-rwxr-xr-x   1 cyy  staff     56  7 22 22:06 HelloWorld.sh
-rw-r--r--   1 cyy  staff   2498  7 17 13:42 IELTS.md

cyy@mac % LS=$(ls -l)
cyy@mac % echo $LS
total 96
drwxr-xr-x  12 cyy  staff    384  7 20 23:19 0720-tmp-files
-rwxr-xr-x   1 cyy  staff     56  7 22 22:06 HelloWorld.sh
-rw-r--r--   1 cyy  staff   2498  7 17 13:42 IELTS.md
```
另外，`$()`支持嵌套，而反引号不行；`$()`仅可在Bash Shell中有效，而反引号可在多种UNIX SHELL中使用。所以各有特点，选哪个看需要和个人喜好

## 运算符
### 算术运算符
```bash
cyy@mac % let I=2+2    #work
cyy@mac % echo $I
4
cyy@mac % let I=15/7  #work
cyy@mac % echo $I
2
cyy@mac % I=2+2       #work
cyy@mac % echo $I
4
cyy@mac % I=15/7      #work
cyy@mac % echo $I
2
cyy@mac % echo "$10%3"    #test
%3
cyy@mac % echo $10%3      #test
%3
cyy@mac % L=10%3          #not work
cyy@mac % echo $L
10%3
cyy@mac % echo "$L"       #not work
10%3
cyy@mac % let L=10%3      #work
cyy@mac % echo $L
1
cyy@mac % A=2*3           #test
cyy@mac % echo $A
2*3
cyy@mac % echo "$A"
2*3
cyy@mac % let A=2*3       #not work
zsh: no matches found: A=2*3
cyy@mac % let B=2*3
zsh: no matches found: B=2*3
```
### 位元算符存疑(忽略)

使用`$[]`做运算：`$[]`与`$(())`类似，可用于简单的算术运算：
```bash
cyy@mac % echo $[1+1]
2
cyy@mac % echo $[2*2]
4
cyy@mac % echo $[5**2]
25
```
### expr 运算
使用expr做运算：expr也可用于整数运算。与其他算数运算不同，expr要求操作数和操作符之间使用空格隔开（否则只会打印出字符串），所以特殊的操作符要使用转义符转义（如*）。
expr支持加减乘除余等：
```bash
cyy@mac % expr 1+1
1+1
cyy@mac % expr 1 + 1
2
cyy@mac % expr 2 * 2
expr: syntax error
cyy@mac % expr 2 \* 2
4
```

### 内建运算命令 declare
declare是shell的内建命令，通过它也能进行整数运算，但使用declare显示定义整数变量（-i 参数指定变量为“整数”），再进行赋值。如不定义，赋值“1+1”便是简单的字符串，与“1+1”无异：
```bash
#不用declare定义变量
cyy@mac % S=1+1
cyy@mac % echo $S
1+1
#用declare定义变量
cyy@mac % declare -i J
cyy@mac % J=1+1
cyy@mac % echo $J
2

#注意，Shell中的算术运算要求 运算符和操作数之间不能有空格；特殊符号也不需要转义；算术表达式中含有其他变量也不需要用$引用。
```

### 算术扩展：shell内建命令之一
整数变量的运算机制，基本语法：```$((算术表达式))```  
其中，算术表达式由变量和运算符组成，常见的用法是显示输出和变量赋值。若表达式中的变量没有定义，则计算时，其值会被假设为0（但不会真的因此赋0值给该变量）：
```bash
cyy@mac % i=2
cyy@mac % echo $((2*i+1))
5
cyy@mac % echo $((2*(i+1)))   #用括号改变运算优先级
6

#变量赋值
cyy@mac % var=$((2*i+1))
cyy@mac % echo $var
5

#未定义的变量参与算术表达式求值 （默认为0）
cyy@mac % var=$((2*j+1))   
cyy@mac % echo $var
1
```

## 通配符
通配符用于模式匹配，常见的通配符有`*`、`？`和`[]`括起来的字符序列。其中：  
* `*`代表任意长度的字符串，但不包括点号和斜线号，也就是`a*`无法匹配`abc.txt`。  
* `？`可用于匹配任何一个单一字符。
* `[]`代表匹配其中的任意一个字符，如`[abc]`表示可以匹配a或者b或者c
* `[]`中可以用`-`表明起止，如`[a-c]`等同于`[abc]`  
    *但注意， `-`在`[]`外只是一个普通字符，没有任何特殊作用；`*`和`？`在`[]`中则变成了普通字符，没有通配的功效

* `{}`大括号：匹配多个排列组合的可能:
```bash
cyy@mac % echo {x1,x2}{y1,y2}
x1y1 x1y2 x2y1 x2y2
```

## 测试
`$?`判断文件是否存在
```bash
cyy@mac % ls /Users/cyy/g/notes
0720-tmp-files  IELTS.md        learnfor.sh     learnwhile.sh   test2.md
HelloWorld.sh   README.md       learnif.sh      quiz.sh
cyy@mac % ls /Users/cyy/g/notes/test2.md
/Users/cyy/g/notes/test2.md
cyy@mac % echo $?
0

cyy@mac % ls /Users/cyy/g/notes/test5.md
ls: /Users/cyy/g/notes/test5.md: No such file or directory
cyy@mac % echo $?                       
1

#输出结果为0，说明存在；输出结果非0，说明不存在。或者用 [ expression ]测试，见下


测试结构
中括号内，表达式前后都有空格，需注意
[ expression ]
```bash
cyy@mac % [ -e /Users/cyy/g/notes/test2.md ]
cyy@mac % echo $?
0

cyy@mac % [ -e /Users/cyy/g/notes/test5.md ]
cyy@mac % echo $?                           
1
```

## if语句
```bash
#! /bin/bash
echo -n "Please input a score"
read SCORE
if [ "$SCORE" -lt 60 ]; then
    echo "C"
fi
if [ "$SCORE" -lt 80 -a "$SCORE" -ge 60 ]; then     
    echo "B"
fi
if [ "$SCORE" -ge 80 ]; then
    echo "A"
fi
```
* ！expression （逻辑测试）表示如果expression为真，则测试结果为假
* *expression 1 -a expression 2 （逻辑测试）表示expression 1和2同时为真，则测试结果为真 （逻辑运算：&&）
* expression 1 -o expression 2 （逻辑测试）表示expression 1和2只要有1个为真，则测试结果为真（逻辑运算：`||`）

>-eq 等于；  
>-gt great than 大于     
>-lt less than 小于  
>-ge great equal 大于等于  
>-le less equal 小于等于  
>-ne not equal 不等于


### if/else语句 判断文件是否存在
```bash
#! /bin/bash
FILE=/Users/cyy/g/notes/test2.md
if [ -e $FILE ];then
    echo "$FILE exists"
else
    echo "$FILE not exists"
fi
```

### if/elif
```bash
#! /bin/bash
echo -n "Please input a score"
read SCORE
if [ "$SCORE" -lt 60 ]; then
    echo "C"
elif [ "$SCORE" -lt 80 -a "$SCORE" -ge 60 ]; then
    echo "B"
else 
    echo "A"
fi
```

## for循环
```bash
#! /bin/bash
for FRUIT in apple orange banana pear
do
    echo "$FRUIT is John's favorite"
done
echo "No more fruits"

#优化版：将列表定义到一个变量中，以后有任何修改只需要修改该变量即可
fruits="apple orange banana pear"
for FRUIT in ${fruits}
do
    echo "$FRUIT is John's favorite"
done
echo "No more fruits"
```
### 列表是数字时，shell提供了用于计数的方式，1到5可以用{1..5}表示：
```bash
#! /bash/bin
for VAR in {1..5}
do
    echo "Loop $VAR times"
done
```

### 结合seq命令求和
* 1-100求和
```bash
#! /bin/bash
sum=0
for VAR in `seq 1 100`
#for VAR in $(seq 1 100)   用$()替换``
do
    let "sum+=VAR"     #啥意思
done
echo "Total: $sum"
```
* 求1-100奇数的和
```bash
#! /bin/bash
sum=0
for VAR in `seq 1 2 100`   #(三个数：首数、增量、尾数)
#for VAR in $(seq 1 2 100)   用$()替换``
do
    let "sum+=VAR"    
done
echo "Total: $sum"
```

# Day 4 20240722 
Linux Shell脚本学习
## 简单脚本的创建和执行 第一个shell脚本：输出 hello world
### 创建文件：cyy@mac % code HelloWorld.sh
Shell脚本永远以“#!”开头，这是一个脚本开始的标记，表示系统执行这个文件需要使用某个解释器（常见的解释器有sh、bash），后面的/bin/bash指明了解释器的具体位置
```bash
cyy@mac % cat HelloWorld.sh
#!/bin/bash   
#This line is a comment
echo "Hello World"
```
### 运行脚本：
1. bash + 脚本
```bash
cyy@mac % bash HelloWorld.sh 
Hello World
```
2. 添加可执行权限（chmod +x ➕脚本），然后使用“./”运行
```bash
cyy@mac % ./HelloWorld.sh
zsh: permission denied: ./HelloWorld.sh
cyy@mac % chmod +x HelloWorld.sh 
cyy@mac % ./HelloWorld.sh 
Hello World
```

## if 语句
### if➕空格 [空格 "……" 空格];空格 then
```bash
#!/bin/bash
SCORE=70
if [ "$SCORE" -lt 60 ]; then
echo "C"
fi
```
### if/esle语句
```bash
#!/bin/bash
SCORE=70
if [ "$SCORE" -lt 60 ]; then
echo "C"
else
echo "B"
fi
```

## for循环
### 基础版
```bash
#!/bin/bash
for i in a b c d 1 2 3
do 
    echo $i
done
```

### 加if/else版
```bash
for i in 50 60 70
do 
    echo $i
    if [ "$i" -lt 60 ]; then
        echo "C"
    else
        echo "B"
    fi
done
```

### seq,输出序列
```bash
cyy@mac % seq 3
1
2
3
```
用for打印1～10

```bash
for i in $(seq 10)
do 
    echo $i
done
```

### “$(命令)”表示获取该命令的结果 to get the result of the command
```bash
cyy@mac % for i in $(ls)
do
    echo $i
done
0720-tmp-files
HelloWorld.sh
IELTS.md
README.md
learnfor.sh
learnif.sh
test2.md
```

## while循环 按行读取文件 常用于处理格式化数据
### 两种读取文件的方式：
1. done后接重定向
```bash
#! /bin/bash
while read line
do 
    echo $line | wc -c
    echo
done < learnif.sh
```
2. while前用cat+管道
```bash
cat learnif.sh | while read line
do 
    echo $line | wc -c
    echo
done 
```

wc表示统计文件的行数（-l）、单词数（-c）和大小
```bash
cyy@mac % wc quiz.sh   
       5       9      48 quiz.sh
cyy@mac % wc -l quiz.sh
       5 quiz.sh
```


## 练习题
输出当前目录下的文件及行数（ls、echo、wc -l），改变输出的列序，一、二列互换并➕逗号隔开（awk），输出结果按第二列倒序排列（sort）
```bash
for i in $(ls)
do
    echo $i 
    wc -l $i | awk '{print $2","$1}'
done  | sort -r -t "," -k 2 -n
```

# Day 3 20240720 
Linux 系统命令及Shell脚本实践指南
## 生成某个文件并添加特定内容 echo
```bash
# 重定向 > 添加并覆盖原有； 追加 >> 最后添加
ehco ABCD > abc.txt 
cyy@mac g % echo The cat\'s > tomAndJerry.txt 
cyy@mac g % cat tomAndJerry.txt
cyy@mac g % echo The cat\'s >> tomAndJerry.txt            
The cat's
The cat's

# 特殊标点加转义符，反斜杠\；换行用 \\n后接次行内容
cyy@mac g % echo The cat\'s name is Tom,what\'s the mouse\'s name\? \\nThe  
The cat's name is Tom,what's the mouse's name? 
The
```

## grep
```bash
#创建一个文本文件
cyy@mac g % cat tomAndJerry.txt
The cat's name is Tom,what's the mouse's name? 
The mouse's NAME is Jerry 
They are good friends

#找出含有name的行
cyy@mac g % grep 'name' tomAndJerry.txt
The cat's name is Tom,what's the mouse's name? 

#打印含有name行的行号 -n 区分大小写
cyy@mac g % grep -n 'name' tomAndJerry.txt
1:The cat's name is Tom,what's the mouse's name? 

#忽略大小写-i
grep -i 'name' tomAndJerry.txt
The cat's name is Tom,what's the mouse's name? 
The mouse's NAME is Jerry

#既输出行又忽略大小写，组合指令，-in 获 -i -n
cyy@mac g % grep -in 'name' tomAndJerry.txt
1:The cat's name is Tom,what's the mouse's name? 
2:The mouse's NAME is Jerry 
cyy@mac g % grep -i -n 'name' tomAndJerry.txt
1:The cat's name is Tom,what's the mouse's name? 
2:The mouse's NAME is Jerry

#输出含有多少个 -c
cyy@mac g % grep -c 'name' tomAndJerry.txt 
1

#反向输出 -v
cyy@mac g % grep -v 'name' tomAndJerry.txt
The mouse's NAME is Jerry 
They are good friends

# 以上都可以用 cat+管道符改写
# 输出不含 name 的行，不区分大小写
cyy@mac g % cat tomAndJerry.txt | grep -vi 'name'
They are good friends
# 输出含有 name 的行，不区分大小写
cyy@mac g % cat tomAndJerry.txt | grep -i 'name' 
The cat's name is Tom,what's the mouse's name? 
The mouse's NAME is Jerry 

```

## sort
```bash
#创建文件
cyy@mac g % echo b:3 \\nc:2 \\na:4 \\ne:5 \\nd:1 \\nf:11 > sort.txt
cyy@mac g % cat sort.txt
b:3 
c:2 
a:4 
e:5 
d:1 
f:11
```
各种参数
```bash
#采取数字排序
cyy@mac g % sort -n sort.txt
a:4 
b:3 
c:2 
d:1 
e:5 
f:11
#对输出内容排序 
cyy@mac g % cat sort.txt | sort                                    
a:4 
b:3 
c:2 
d:1 
e:5 
f:11
#反向排序
cyy@mac g % cat sort.txt | sort -r            
f:11
e:5 
d:1 
c:2 
b:3 
a:4 
#指定分隔符、指定列排序， 指定 ：为分隔符，并按第二行排序
cyy@mac g % cat sort.txt | sort -t ":" -k 2
d:1 
f:11
c:2 
b:3 
a:4 
e:5 
#指定分隔符、指定列排序， 指定 ：为分隔符，并按第二行的数字排序 -n
cyy@mac g % cat sort.txt | sort -t ":" -k 2 -n
d:1 
c:2 
b:3 
a:4 
e:5 
f:11

```

## uniq
```bash
#创建文件,除先touch创建txt再ehco编辑内容外，还可以code ➕ 文件名 ➕回车，然后编辑器内编辑内容
abc
123
abc
123

#如果出现%，说明内容结束，可再增加一行空行，%则会自动消失
cyy@mac g % cat uniq.txt
abc
123
abc
123%  
```
```
# uniq只能删除相邻行的重复，所以下面文件无变化；uniq一般结合sort使用
cyy@mac g % cat uniq.txt | uniq
abc
123
abc
123
# 结合sort使用，并注意使用管道符
cyy@mac g % cat uniq.txt | sort | uniq
123
abc
# 加参数 -c，表示改行重复的数
cyy@mac g % cat uniq.txt | sort | uniq -c
   2 123
   2 abc
```

## cut截取文本，处理的对象是“一行”

```bash
创建文件 找出示例文件的前5行
cyy@mac g % cat /etc/passwd | grep ':'| head -n 5  
nobody:*:-2:-2:Unprivileged User:/var/empty:/usr/bin/false
root:*:0:0:System Administrator:/var/root:/bin/sh
daemon:*:1:1:System Services:/var/root:/usr/bin/false
_uucp:*:4:4:Unix to Unix Copy Protocol:/var/spool/uucp:/usr/sbin/uucico
_taskgated:*:13:13:Task Gate Daemon:/var/empty:/usr/bin/false
```

```bash
# -f\n -d'\m' 以m为换行符，输出第n列的内容
cyy@mac g % cat cut.txt |cut -f1 -d':'
nobody
root
daemon
_uucp
_taskgated

# 以“/"为换行符，输出第4-5两列的内容
cyy@mac g % cat cut.txt |cut -f4-5 -d'/'
usr/bin
bin/sh
usr/bin
uucp:/usr
usr/bin

# 不指定换行符，输出每行1-10个字符 -c
cyy@mac g % cat cut.txt |cut -c1-10     
nobody:*:-
root:*:0:0
daemon:*:1
_uucp:*:4:
_taskgated

```

## tr 文本替换
```bash
# 把所有小写字母转换为大写字母
cyy@mac g % cat cut.txt |tr '[a-z]' '[A-Z]'
NOBODY:*:-2:-2:UNPRIVILEGED USER:/VAR/EMPTY:/USR/BIN/FALSE
ROOT:*:0:0:SYSTEM ADMINISTRATOR:/VAR/ROOT:/BIN/SH
DAEMON:*:1:1:SYSTEM SERVICES:/VAR/ROOT:/USR/BIN/FALSE
_UUCP:*:4:4:UNIX TO UNIX COPY PROTOCOL:/VAR/SPOOL/UUCP:/USR/SBIN/UUCICO
_TASKGATED:*:13:13:TASK GATE DAEMON:/VAR/EMPTY:/USR/BIN/FALSE%

# 替换，把所有/替换为“:”
cyy@mac g % cat cut.txt |tr '/' ':'        
nobody:*:-2:-2:Unprivileged User::var:empty::usr:bin:false
root:*:0:0:System Administrator::var:root::bin:sh
daemon:*:1:1:System Services::var:root::usr:bin:false
_uucp:*:4:4:Unix to Unix Copy Protocol::var:spool:uucp::usr:sbin:uucico
_taskgated:*:13:13:Task Gate Daemon::var:empty::usr:bin:false% 

# 把多个字符替换成换行 
cyy@mac g % cat cut.txt |tr ':/v1' '\n'
nobody
*
-2
-2
Unpri
ileged User

# -s squeeze 多个连续字符被单个字符代替
cyy@mac g % echo aa,b,,b,,,cc,,,,,,dd | tr  -s ',acd'
a,b,b,c,d

# -d 删除输入流中的个别字符
cyy@mac g % echo aa,b,,b,,,cc,,,,,,dd | tr  -d ','   
aabbccdd
cyy@mac g % echo aa,b,,b,,,cc,,,,,,dd | tr  -d ',b'
aaccdd

#删除所有字母
cyy@mac g % echo aa,b,,b,,,cc,,,,,,dd | tr  -d '[a-z]'
,,,,,,,,,,,,

```

## paste 文本合并

```bash
# 创建a.txt b.txt并合并
cyy@mac g % cat a.txt
1
2
3
cyy@mac g % cat b.txt
a
b
c%                                                                                                                
cyy@mac g % paste a.txt b.txt
1       a
2       b
3       c

# -d 指定合并符，注意 冒号可不加引号，其他合并符需要加引号
cyy@mac g % paste -d: a.txt b.txt
1:a
2:b
3:c
cyy@mac g % paste -d* b.txt a.txt
zsh: no matches found: -d*
cyy@mac g % paste -d'*' b.txt a.txt
a*1
b*2
c*3
cyy@mac g % paste -d'5' b.txt a.txt
a51
b52
c53

```
## sed 
创建文件
```bash
this is line1,this is First line
this is line 2,the Second line,Empty line followed
this is line 4,this is Third line
this is line 5, this is Fifth line
```

```bash
#sed 删除指定行（不修改源文件）
删除第二行
cyy@mac g % sed '2d' sed.txt
this is line1,this is First line
this is line 4,this is Third line
this is line 5, this is Fifth line%

#sed 删除指定行（修改源文件） 参数 -i，但注意先备份（'.bak'）
cyy@mac g % sed -i '.bak'  '1d' sed.txt
删除后需cat显示

# 以上书里建议的操作是，不在源文件修改，重新定向生成一个新文件
cyy@mac g % sed '1d' sed.txt > save_file
cyy@mac g % cat sed.txt  #源文件不变
this is line1,this is First line
this is line 2,the Second line,Empty line followed
this is line 4,this is Third line
this is line 5, this is Fifth line%                                                                               
cyy@mac g % cat save_file  #生成的新文件
this is line 2,the Second line,Empty line followed
this is line 4,this is Third line
this is line 5, this is Fifth line%  


#替换
cyy@mac g % sed 's/line/LINE/' sed.txt
this is LINE1,this is First line
this is LINE 2,the Second line,Empty line followed
this is LINE 4,this is Third line
this is LINE 5, this is Fifth line% 

input 2种方式：1.  读文件 (cat xx.txt)，2. 从pipe 获取（xxx| cat）
#上述替换也可写为
cyy@mac g % cat sed.txt | sed 's/line/LINE/'
this is LINE1,this is First line
this is LINE 2,the Second line,Empty line followed
this is LINE 4,this is Third line
this is LINE 5, this is Fifth line% 
```

## awk 基于列的文本处理工具（与sed相对，sed是基于行的文本处理工具）

创建文本
```bash
john.wang   Male    30  021-11111111
lucy.wang   Female  25  021-22222222
jack.wang   Male    35  021-33333333
lily.wang   Female  20  021-44444444
```

```bash
#打印指定域 
cyy@mac g % awk '{print $4,$3,$2,$2,$1}' awk.txt #调整列序和数量
021-11111111 30 Male Male john.wang
021-22222222 25 Female Female lucy.wang
021-33333333 35 Male Male jack.wang
021-44444444 20 Female Female lily.wang

#指定打印分隔符
cyy@mac g % awk -F- '{print $2}' awk.txt  #指定 - 为分隔符，并输出$2
11111111
22222222
33333333
44444444
cyy@mac g % awk -F'ale' '{print $1}' awk.txt  #指定 ale 为分隔符，并输出$1
john.wang   M
lucy.wang   Fem
jack.wang   M
lily.wang   Fem

#打印指定列
cyy@mac g % awk '{print NF}' awk.txt  #首先确定共有多少列（默认分隔符）NF 表示 Number
4
4
4
4
cyy@mac g % awk -F. '{print NF}' awk.txt  #首先确定共有多少列（指定分隔符）
2
2
2
2

cyy@mac g % awk '{print $(NF-1)}' awk.txt  #输出倒数第二列，NF-1
30
25
35
20

```

## 练习题 1
```bash
原文：网页复制后pbpaste自动粘贴内容
cyy@mac g % pbpaste
14.1.3 实践磁盘配额流程-1：文件系统的支持与查看 469
14.1.4 实践磁盘配额流程-2：查看磁盘配额报告数据 469
14.1.5 实践磁盘配额流程-3：限制值设置方式 470
14.1.6 实践磁盘配额流程-4：project的限制（针对目录限制）（Optional） 471

#提取冒号后面的内容
cyy@mac g % pbpaste|cut -f2 -d'：'
文件系统的支持与查看 469
查看磁盘配额报告数据 469
限制值设置方式 470

#不要数字
cyy@mac g % pbpaste|cut -f2 -d'：'| cut -f1 -d' '
文件系统的支持与查看
查看磁盘配额报告数据
限制值设置方式
project的限制（针对目录限制）（Optional）

#不要括号带英文的
cyy@mac g % pbpaste|cut -f2 -d'：'| cut -f1 -d' '| cut -f1-2 -d'（'
文件系统的支持与查看
查看磁盘配额报告数据
限制值设置方式
project的限制（针对目录限制）
```
## 练习题 2 
复制网站源码以后提取网站- 先把双引号替换成换行、读取http（https）、确定分隔符➕截取对应列
```bash
cyy@mac ~ % pbpaste |tr '"' '\n' |grep http | grep https|cut -f1-3 -d'/'
https://pagead2.googlesyndication.com
https://schema.org
https://static.book345.com
```

## head 和 tail 查看文件的开头或结尾几行
```bash
cyy@mac g % head -n2 sed.txt
this is line1,this is First line
this is line 2,the Second line,Empty line followed

cyy@mac g % tail -n2 sed.txt
this is line 4,this is Third line
this is line 5, this is Fifth line%

cyy@mac g % cat sed.txt| head -n2
this is line1,this is First line
this is line 2,the Second line,Empty line followed
cyy@mac g % cat sed.txt| tail -n2
this is line 4,this is Third line
this is line 5, this is Fifth line% 
```

# Day 2 20240715  
## Linux实操篇 实用指令
- P24 pwd 显示当前工作目录的绝对路径
- ls -a 显示当前目录所有的文件和目录，包括隐藏的
  -l 列表形式显示
  -al 显示隐藏文件
- cd 切换目录  cd 或 cd ~,回到家目录；cd .. 回到当前目录的上一级目录;  .  current dir
- 绝对路径切换，两个文件夹需是相同等级 如Desktop 和 Movies  Movies % cd ../Desktop 
相对路径：不是相同等级

- P25 mkdir
mkdir 创建目录 *不需要进入该目录，保持在上一级就可以; -p 创建多级目录
rm 删除 rmdir删除空目录 rm -r 删除目录（非空目录）

- P26 touch 创建空文件  touch 文件名➕后缀名，可一次性创建多个
    
    cp copy指令 拷贝文件到指定目录 cp[选项] source dest；cp -r 递归复制整个文件夹
    ##注意当前目录位置

- P27 rm指令 -r 递归删除整个文件夹； -rf删除目录
mv指令 移动或重命名 重命名：
    mv oldNamefile newNamefile 移动 #移动没搞懂 解答 ../上级目录，./同级目录


## pbpaste and pipe
```
# This will copy all the content within a file.
$ cat myfile.txt | pbcopy
# This will output the contents of your clipboard.
$ pbpaste
```

| called pipe 从前到后

pbpaste | grep xxx

grep xxx -r .

ctrl + v  stop 

## open from Terminal 

```
cd g/notes
code .
```

# Day 1 20240714 
Learn Linux 

* git status; git add .; git commit -m "$( date "+%Y-%m-%d %T")"; git push

* command+j open terminal

day 1 practice git

https://www.runoob.com/linux/linux-system-contents.html

https://www.runoob.com/linux/linux-file-attr-permission.html

https://www.runoob.com/linux/linux-file-content-manage.html

https://www.runoob.com/linux/linux-vim.html 

