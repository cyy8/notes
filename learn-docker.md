

# Day 10 20240728
每天5分钟玩转docker  
read Chapter 2、3、4；the rest not now

## Docker 基础命令
* 查看已下载到本地的镜像 docker images

```sh
  notes git:(main) ✗ docker images     #docker images 查看已下载到本地的镜像
REPOSITORY                 TAG       IMAGE ID       CREATED        SIZE
ubuntu                     22.04     d04dcc2ab57b   4 weeks ago    69.2MB
ubuntu                     24.04     ffb64c9b7e8b   7 weeks ago    101MB
docker/welcome-to-docker   latest    648f93a1ba7d   8 months ago   19MB
```
* 查看运行中的容器 docker ps
```sh
➜  notes git:(main) ✗ docker ps       #docker ps 查看运行中的容器
CONTAINER ID   IMAGE                             COMMAND                   CREATED       STATUS       PORTS                  NAMES
f9d7efe80d21   centos:centos7                    "/bin/bash -c 'echo …"   2 hours ago   Up 2 hours                          centos7
ce4c47585e31   ubuntu:24.04                      "/bin/bash -c 'echo …"   2 hours ago   Up 2 hours                          ubuntu-2404
cbadb9479ba5   docker/welcome-to-docker:latest   "/docker-entrypoint.…"   3 hours ago   Up 3 hours   0.0.0.0:8088->80/tcp   welcome-to-docker
```
* 搜索docker hub中的镜像（无需开浏览器）`docker search httpd`
```sh
docker search httpd 
NAME                           DESCRIPTION                                      STARS     OFFICIAL
httpd                          The Apache HTTP Server Project                   4756      [OK]
paketobuildpacks/httpd                                                          0         
paketobuildpacks/php-httpd                                                      0              
mprahl/s2i-angular-httpd24     An S2I image for building and running Angula…   3         
httpdocker/kubia                       
```

* ps -a 显示所有的容器，包括已退出的
```sh
➜  notes git:(main) ✗ docker run ubuntu:22.04  
➜  notes git:(main) ✗ docker ps -a           # docker ps -a 显示所有的容器，包括已退出的
CONTAINER ID   IMAGE                             COMMAND                   CREATED          STATUS                      PORTS                  NAMES
03c1fb510166   ubuntu:22.04                      "/bin/bash"               26 seconds ago   Exited (0) 26 seconds ago   # ubuntu:22.04 已退出
```
* -d后台运行 sleep infinity 让容器保持运行不退出

```sh
docker run -d ubuntu:22.04 /bin/bash -c "sleep infinity" #-d后台运行 sleep infinity 让容器保持运行不退出

80c1031379a6b2226dd4a3c3c6f068be95f66b051fb71a38c13f63e0d68b6865
docker ps

CONTAINER ID   IMAGE                             COMMAND                   CREATED          STATUS          PORTS                  NAMES
80c1031379a6   ubuntu:22.04                      "/bin/bash -c 'sleep…"   7 seconds ago    Up 6 seconds                           awesome_stonebraker
c27524f572c8   ubuntu:22.04                      "/bin/bash -c 'sleep…"   45 seconds ago   Up 44 seconds  
```

```sh
bash -c #-c string If the -c option is present, then commands are read from string.
➜  notes git:(main) ✗ bash -c "echo hi"
hi
```
* docker stop 停止容器命令

```sh
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
```sh
# exec 进入容器
➜  notes git:(main) ✗ docker exec -it cyy bash #-it表示打开交互终端，进入容器
# exit 退出容器
```

* docker logs 查看容器日志
* docker run -it 
    * 启动后进入容器，退出后容器自动删除；用于一次性  


```sh
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