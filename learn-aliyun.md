
# Day 16 20240804

阿里云 Aliyun 4h

## 阿里云 Aliyun

### What & Why

- [云计算](https://www.aliyun.com/getting-started/what-is/what-is-cloud-computing?spm=5176.29006181.J_J6oP6NLt6fnI4EatE_sSm.1.3cd45ccaeW9S92#e04e41b07f3ge)，简称“云”，是一种通过互联网提供计算资源和服务的技术，用户可以随时访问和使用云上资源
- 云计算是IT行业的基础设施，越来越多的公司将其业务迁移到云上
- 阿里云是云计算服务平台，为用户提供计算、存储、网络等服务


### [云服务器ECS](https://help.aliyun.com/zh/ecs/getting-started/getting-started?spm=a2c4g.11186623.0.0.2c416472NxQeNh)

- ECS 就是阿里云的云服务器，即虚拟机 VM
- 云服务器ECS（Elastic Compute Service）， 是阿里云提供的弹性扩展的云计算服务，让用户可以便捷、高效地使用服务器
- 免去了采购IT硬件的前期准备，实现计算资源的即开即用和弹性伸缩


#### 云服务器的计费方式

* 按量付费，先使用，后付费，按照各计费项的实际用量结算费用，。
* 包年包月，包周期预付费方式，按订单的购买周期计费。

### [Linux系统实例快速入门](https://help.aliyun.com/zh/ecs/getting-started/quick-start-for-linux-instances?spm=a2c4g.11186623.0.i23)


#### [SSH密钥对](https://help.aliyun.com/zh/ecs/user-guide/overview-ssh?spm=a2c4g.11186623.0.i2)

- 通过SSH密钥对，实现免密码远程登录
- 生成SSH密钥对 `ssh-keygen`
```sh
➜  ssh-keygen
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/cyy/.ssh/id_ed25519): id_rsa
```

- 把公钥（id_rsa.pub）上传到机器 `~/.ssh/authorized_keys` 文件

```sh
vi /root/.ssh/authorized_keys
```

- 不登录的情况下，在远程服务器执行简单命令

```sh
➜  .ssh ssh ecs uptime
 15:33:24 up 51 min,  3 users,  load average: 0.00, 0.00, 0.00
➜  .ssh ssh ecs echo hi
hi
```

#### 通过密钥认证登录Linux实例

- ssh root@<IP> 或者 使用 .ssh/config 文件保存信息
- 登录：`ssh ecs`
- 查看 config 文件

```sh
➜  ~ cat .ssh/config 
# 输入ECS实例的别名，用户SSH远程连接。
Host ecs
# 输入ECS实例的公网IP地址。
HostName 47.**.**.140
# 输入端口号，默认为22。
Port 22
# 输入登录账号。
User root
```

#### 使用scp复制文件到远程主机
- scp Secure copy program 安全复制程序，使用ssh传输
- scp格式为：
    - `scp filename user@remotehost:/home/path` 从本机复制到远程服务器
    - `scp user@remotehost:/home/path/filename .` 从远程服务器复制到本机
- scp -r 复制目录
```sh
➜  ~ scp test.txt ecs:/root #从本机复制到远程服务器
test.txt                                                100%    0     0.0KB/s   00:00
```
```sh
➜  ~ scp ecs:/root/test.txt . #从服务器复制到本机的当前目录， `.`表示当前目录
➜  ~ scp ecs:/root/test.txt test2.txt #将服务器文件复制到本地（默认当前目录），并重命名
```

#### [安全组](https://help.aliyun.com/zh/ecs/user-guide/after-the-security-group?spm=a2c4g.11186623.0.0.c2f248f0NuADm1)

- 安全组是一种虚拟防火墙，能够控制ECS实例的出入站流量。
- 安全组的入方向规则控制ECS实例的入站流量，出方向规则控制ECS实例的出站流量。

#### [什么是云存储？](https://www.aliyun.com/getting-started/what-is/what-is-cloud-storage?spm=a2c4g.11186623.0.0.9eae1eb70RClYA)
- 云存储是一种数据存储在远端服务器集群在线访问的存储类型，用户无需关注存储位置。
- 云存储服务提供商负责安全地存储、管理和维护存储服务器、基础设施和网络。
- 基于高度虚拟化的基础架构云存储可以提供广泛的弹性来应对不确定性的容量和性能的诉求。

- 阿里云对象存储**OSS（Object Storage Service）**：
    - 适用于存储和管理大量非结构化数据，如图片、视频、音频、文档等
    - 数据以对象的形式存储，并具有自定义的元数据，使数据更易于访问和管理
    - 对象存储不像传统的文件系统那样以文件和文件夹层次结构组织数据，而是将数据存储在具有高度可扩展性的存储空间（Bucket）中


### [专有网络VPC](https://help.aliyun.com/zh/vpc/?spm=a2c4g.750001.0.0.49aa1ec4aIqdgs)

- 专有网络VPC（Virtual Private Cloud）是用户的云上私有网络。用户可以设置自己的专有网络，例如选择IP地址范围、配置路由表和网关等，并在自己定义的专有网络中使用阿里云资源
    - 每个专有网络都由至少一个私网网段、一个虚拟路由器和至少一个交换机组成。
    - 专有网络是地域级别的资源，专有网络不可以跨地域，但包含所属地域的所有可用区
        - 地域 Region， 上海，杭州等
        - 可用区 Available Zone ，可用区 A， B, C 
- 交换机：专有网络的每个可用区内，可以通过创建一个或多个交换机来划分子网
- 路由表：创建VPC后，系统自动生成一张系统路由表
    - 系统路由表：系统自动创建，用户不可创建和删除
    - 自定义路由表：用户可以在VPC内创建自定义路由表，通过自定义路。看，     ·由表和交换机绑定，将交换机网段作为目标网段，用于交换机内的云产品通信
    - 网关路由表：用户可在VPC内创建自定义路由表，将自定义路由表和IPv4网关绑定，控制进入VPC的公网流量的路由


<!--
### 什么是函数计算

- 函数计算是Serverless架构的一种形态，面向函数编程，基于事件驱动提供阿里云云服务之间端到端的解决方案。借助函数计算，您可以快速构建任何类型的应用和函数，并且只需为任务实际消耗的资源付费。
- 使用函数计算，您无需采购与管理服务器等基础设施，只需编写并上传代码或镜像。函数计算为您准备好计算资源，弹性地、可靠地运行任务，并提供日志查询、性能监控和报警等功能。
- 相对于Serverful，Serverless 可以让业务人员无需关注服务器，仅聚焦于业务逻辑代码，并支持按实际使用付费。

#### 阿里云函数计算 Golang Runtime SDK

- https://github.com/aliyun/fc-runtime-go-sdk/tree/master

```sh
# 针对M1 macOS（或其他ARM架构的机器），配置GOARCH=amd64，实现跨平台编译
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main main.go
zip my-function.zip main
```
-->