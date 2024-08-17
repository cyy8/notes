

# Day 23 - 20240811

## 《每天5分钟玩转Kubernetes》  

### Kubernetes 健康检查 (Health Check) 功能

自愈能力是 k8s 的重要特性，默认实现方式是自动重启发生故障的容器。

健康检查的两种机制：

- Liveness 探测（livenessProbe）：用户可自定义判断容器是否健康的条件（是否正常运行），探测失败则重启容器

    Indicates whether the container is running. 

- Readiness 探测（readinessProbe）：告诉 k8s 何时可以将容器加到 Service 负载均衡池中，对外提供服务

    Indicates whether the container is ready to respond to requests. 

### Secret & ConfigMap

向 Pod 传递配置信息时，如果是敏感信息，可使用Secret；一般配置信息，则使用ConfigMap。  
容器可以通过文件或环境变量的方式使用这些数据。

- Secret
    - 以密文的方式存储数据
    - 以 Volume 的形式被 mount 到 pod
    - 可以通过命令行或 YAML 创建

- Configmap：以明文方式存放非敏感数据

### Kubernetes 存储 - 卷 Volume

- why need Volume
    - 容器和Pod生命周期短，会被频繁销毁和创建，销毁时容器内部数据会被清除
    - Volume 可以持久化保存容器的数据
- Volume
    - 生命周期独立于容器，Pod中的容器可能会被销毁和重建，但Volume会被保留
    - 本质一个目录
- emptyDir Volume
    - 最基础的 Volume 类型，是 Host 上创建的临时目录（不具备持久性）
- hostPath Volum
    - Host 系统中存在的目录，mount给Pod的容器
    - Pod被销毁，hostPath 对应的目录还是会保留（持久性高于emptyDir）

### [持久卷 PersistentVolume (PV) & 持久卷申领 PersistentVolumeClaim (PVC）](https://kubernetes.io/zh-cn/docs/concepts/storage/persistent-volumes/)

emptyDir 和 hostPath 都依赖于 K8s；而 PV和 PVC 是与集群分离的，数据被持久化后，即使 K8s 崩溃也不会受损。

- PV 持久卷: 是外部存储系统中的一块存储空间，由管理员创建和维护。具有持久性，生命周期独立于Pod
- PVC 持久卷申领
    - 对PV的申请（claim），通常由普通用户创建和维护
    - 需要Pod分配存储资源时，用户可以创建PVC，并指明存储资源的容量大小和访问模式，K8s 会查找并提供满足条件的PV


## Workload Management

Usually you don't need to create Pods directly. Instead, create them using workload resources such as Deployment or Job.

You use the Kubernetes API to create a workload object that represents a higher abstraction level than a Pod, and then the Kubernetes control plane automatically manages Pod objects on your behalf, based on the specification for the workload object you defined.

The built-in APIs for managing workloads are:

* A **Deployment** manages **a set of Pods** to run an application workload, usually one that **doesn't maintain state**.
* A **DaemonSet** ensures that **all (or some) Nodes** run **a copy of a Pod**.
* A **Job** or **CronJob** to define tasks that run to completion and then stop. A Job represents a **one-off task**, whereas each CronJob repeats according to a **schedule**.
* A **StatefulSet** manages its Pods and their **persistent storage**. For example, you can run a StatefulSet that associates each Pod with a PersistentVolume.


# Day 22 - 20240810

* 《每天5分钟玩转Kubernetes》 3h 
* [Workload Management in K8s](https://kubernetes.io/docs/concepts/workloads/controllers/) 1h


## 《每天5分钟玩转Kubernetes》

### 运行应用 Deployment

* 运行 Deployment 的总过程

    1. 用户通过 kubectl 创建 Deployment (deployment.apps/nginx-deployment created）
    2. Deployment 创建 ReplicaSet (deployment-controller, Scaled up replica set nginx-deployment-54c4fc9b4b to 2)
    3. ReplicaSet 创建 Pod (replicaset-controller, Created pod: nginx-deployment-54c4fc9b4b-b5bwl)

* Create deployment

```sh
k create deployment nginx-deployment --image=nginx:latest --replicas=2    # 与书上不一致，`k run` is deprecated，and `deployment` should be added
```
* kubectl describe deployment: show details
```sh
k describe deployment nginx-deployment
Name:                   nginx-deployment
Namespace:              default
CreationTimestamp:      Sat, 10 Aug 2024 11:08:31 +0800
Labels:                 app=nginx-deployment
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx-deployment
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-deployment
  Containers:
   nginx:
    Image:        nginx:latest
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deployment-54c4fc9b4b (2/2 replicas created)
Events:         # Deployment的日志，记录了Replicaset的启动过程
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  16m   deployment-controller  Scaled up replica set nginx-deployment-54c4fc9b4b to 2
```

- ReplicaSet
```sh
 k describe replicaset nginx-deployment-54c4fc9b4b 
Name:           nginx-deployment-54c4fc9b4b
Namespace:      default
Selector:       app=nginx-deployment,pod-template-hash=54c4fc9b4b
Labels:         app=nginx-deployment
...
Controlled By:  Deployment/nginx-deployment  # 说明此ReplicaSet是由nginx- deployment创建
Replicas:       2 current / 2 desired
Pods Status:    2 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=nginx-deployment
           pod-template-hash=54c4fc9b4b
  ...
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  25m   replicaset-controller  Created pod: nginx-deployment-54c4fc9b4b-gr2z5
  Normal  SuccessfulCreate  25m   replicaset-controller  Created pod: nginx-deployment-54c4fc9b4b-b5bwl
```

### 命令(Imperative)vs配置文件(Declarative)

k8s支持两种创建资源的方式：命令、配置文件
- 用 kubectl 命令直接创建
- 配置文件 `yaml` 和 `kubectl apply` 命令
    `kubectl apply -f nginx.yml`

### Deployment YAML file

```sh
k get deployment nginx-deployment -oyaml|head -n40
```

```yaml
apiVersion: apps/v1     # 当前配置的版本
kind: Deployment        # 要创建的资源类型，如Service、Job等
metadata:               # metadata是该资源的元数据
  name: nginx-deployment     # name是元数据的必须选项
  namespace: default
  annotations:         
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-08-10T03:08:31Z"
  generation: 1
  labels:
    app: nginx-deployment
  resourceVersion: "154655"
  uid: 5e0df2e7-a540-4058-beca-598d2804d99e
spec:                   # Specification 该 Deployment 的 规格说明
  progressDeadlineSeconds: 600
  replicas: 2           # 副本数量，默认为1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-deployment
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:     # 定义Pod 的模版，配置文件中的重要部分
    metadata:   # 定义Pod的元数据，至少需要定义一个label
      creationTimestamp: null
      labels:       # 至少定义一个
        app: nginx-deployment   # label的key和value可以任意指定
    spec:       # 描述Pod的规格，此部分定义Pod中每一个容器的属性，name 和 image 是必须的
      containers:
      - image: nginx:latest     # image是必须的
        imagePullPolicy: Always
        name: nginx             # name也是必须的
        resources: {}
      dnsPolicy: ClusterFirst
      restartPolicy: Always
```

- Update resource
 - 修改 YAML 文件，执行 kubectl apply -f 命令

### DaemonSet

- 每个Node最多只能运行一个Pod
- 应用场景
    - 在每个节点上运行 **日志收集** agent
    - 在每个节点上运行 **监控** agent

### 通过 Service 访问 Pod

- Why need Service
    - 每个Pod都有自己的IP地址，Controller会用新Pod替代发生故障的Pod，新Pod的IP地址会变
    - Service提供固定IP，帮助客户端访问Pod
- What is Service
    - K8s Service 逻辑上代表了一组Pod，通过 label selector 选择对应的Pod
    - Service 有自己固定不变的IP
    - 客户端只需访问 Service 的 IP，K8s 负责建立和维护 Service 和 Pod 的映射
- Cluster IP 是一个虚拟 IP，由 K8s 节点上的 iptables 规则管理
- Cluster 中的 Pod 可以通过`<SERVICE_NAME>.<NAMESPACE_NAME>`访问Service，eg：httpd-svc.default
- Service 的 4 种类型
    - ClusterIP
    - NodePort
    - LoadBalancer
    - ExternalName

> `ctrl R 关键词`，搜索以前的命令   

## k8s文档学习

### [Overview](https://kubernetes.io/docs/concepts/overview/)

- K8s: portable, extensible, open source platform for managing containerized workloads and service
- About "编排器" 

> Additionally, Kubernetes is not a mere orchestration system. In fact, it **eliminates** the need for orchestration. The technical definition of orchestration is execution of a defined workflow: first do A, then B, then C. In contrast, Kubernetes comprises a set of independent, composable control processes that continuously **drive the current state towards the provided desired state**. It shouldn't matter how you get from A to C. Centralized control is also not required. This results in a system that is easier to use and **more powerful, robust, resilient, and extensible**.


https://kubernetes.io/docs/concepts/overview/working-with-objects/#kubernetes-objects

https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/


## [Kubernetes (K8s)](https://kubernetes.io/docs/concepts/architecture/)

《Kubernetes 快速入门（第2版）》 

### Kubernetes 简介
* 名字由来
    - Kubernetes 来自希腊语，意为"舵手"
    - 简称"K8s", 发音为"kates"，8表示K和s之间的8个字符
* 是什么（容器管理平台）
    - K8s是云原生微服务（cloud-native microservice）应用的编排器。运行和管理容器化的应用，实现扩缩容、自我修复、不停机部署等。
- 何为微服务
    - 单体应用：所有功能紧密耦合，整体部署、升级和扩缩容，笨重，风险大，开发周期长
    - 微服务：与"单体应用"相对，拆分为小的服务，松散耦合，每个服务独立开发和部署，高效
- 何为云原生
    - 按需扩缩容: 根据需求量，自动添加或减少资源
    - 支持滚动更新: 指不中断服务，逐个更新
    - 自我修复: 某个实例故障时，启动副本替代
    - 在任何k8s上运行: 通用灵活，不受平台限制
- 何为编排器
    - 管理和组织微服务应用，提供自动扩缩容、自我修复，更新等功能

### Kubernetes 集群的组成

* 集群(cluster)
    * 多台机器组成一个 Kubernetes 集群
    * 集群中的机器称为节点 Node

* 主节点，Control Plane Node(Master Node): 运行系统服务，是集群的"大脑"
    * API 服务器 (API server)，集群中心，负责组件之间的通信
    * 调度器 (Scheduler)，负责将服务调度到合适的节点上
    * 控制器 (Controller Manager)，负责管理服务状态
    * 集群存储 (etcd)，存储集群配置数据

* 工作节点，Worker Node: 运行用户服务
    * kubelet 是 Node 的 agent，将工作节点加入集群，并与Master通信，接收任务和报告任务状态
    * 容器运行时(Container Runtime)，负责启动、运行和停止容器。最初是Docker，后来是Containerd
    * kube-proxy 服务，负责容器之间的通信和负载均衡

### 托管版集群 hosted Kubernetes
* 云厂商构建集群，并维护控制平面
* 用户只需管理工作节点、部署应用

### [kubectl 管理 k8s 集群的命令行工具](https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/)

- `kubectl` 读作 "Kube see tee ell"
- kubectl 获取 node 和 pod

```sh
➜  ~ kubectl get node      # 列出集群所有节点
NAME             STATUS   ROLES           AGE   VERSION
docker-desktop   Ready    control-plane   19h   v1.29.2
➜  ~ kubectl get pod       # 列出当前namespace的所有Pod
No resources found in default namespace.
➜  ~ kubectl get pod -A    # -A表示all namespace
NAMESPACE     NAME                                     READY   STATUS    RESTARTS   AGE
kube-system   coredns-76f75df574-chc2r                 1/1     Running   0          19h
kube-system   etcd-docker-desktop                      1/1     Running   0          19h
kube-system   kube-apiserver-docker-desktop            1/1     Running   0          19h
kube-system   kube-controller-manager-docker-desktop   1/1     Running   0          19h
kube-system   kube-proxy-qh6vl                         1/1     Running   0          19h
kube-system   kube-scheduler-docker-desktop            1/1     Running   0          19h
kube-system   storage-provisioner                      1/1     Running   0          19h
```

- kubectl创建deployment，启动Pod

```sh
➜  ~ kubectl create deployment --image=nginx nginx-app
deployment.apps/nginx-app created

➜  ~ k get deploy      #deployment 部署集，指定需要运行的Pod及数量
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginx-app   1/1     1            1           15s

➜  ~ kubectl get pod
NAME                        READY   STATUS              RESTARTS   AGE
nginx-app-5777b5f95-5fk2m   0/1     ContainerCreating   0          12s

➜  ~ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
nginx-app-5777b5f95-5fk2m   1/1     Running   0          9s
```

- kubectl exec 容器中执行命令

```sh
➜  ~ kubectl exec nginx-app-5777b5f95-5fk2m -- echo hi     #不打开终端，直接执行命令
hi

➜  ~ kubectl exec -it nginx-app-5777b5f95-5fk2m -- /bin/sh # -it 打开交互终端，使用bin/sh
# uname
Linux
# ls
bin   dev		   docker-entrypoint.sh  home  media  opt   root  sbin	sys  usr
boot  docker-entrypoint.d  etc			 lib   mnt    proc  run   srv	tmp  var
#
```

- kubectl log 查看容器的日志
```sh
➜  ~ k logs nginx-app-5777b5f95-   #查看容器的日志
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
2024/08/08 07:27:20 [notice] 1#1: start worker process 35

➜  ~ k logs -f nginx-app-5777b5f95-5fk2m   # -f表follow，查看实时日志
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
2024/08/08 07:27:20 [notice] 1#1: start worker process 35
^C

➜  ~ k logs --previous nginx-app-5777b5f95-5fk2m   # 查看重启前容器的日志
Error from server (BadRequest): previous terminated container "nginx" in pod "nginx-app-5777b5f95-5fk2m" not found
```

- kubectl delete pod 删除 Pod
```sh
➜  ~ k delete pod nginx-app-5777b5f95-5fk2m    # kubectl delete pod NAME 删除Pod
pod "nginx-app-5777b5f95-5fk2m" deleted

➜  ~ k get pod
NAME                        READY   STATUS              RESTARTS   AGE
nginx-app-5777b5f95-98t8z   0/1     ContainerCreating   0          7s

➜  ~ k get pod     # 一个被删除后，自动创建新的Pod
NAME                        READY   STATUS    RESTARTS   AGE
nginx-app-5777b5f95-98t8z   1/1     Running   0          34s
```

- 删除部署集deployment, 彻底删除Pod

```sh
➜  ~ k get deploy
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginx-app   1/1     1            1           30m
➜  ~ k delete deploy nginx-app
deployment.apps "nginx-app" deleted
➜  ~ k get pod
No resources found in default namespace.
```

- -v 显示详细请求过程；数字表示详细程度，数字越大越详细
```sh
➜  ~ k get Pod -v 7
I0808 16:08:29.837025    2293 loader.go:395] Config loaded from file:  /Users/cyy/.kube/config
I0808 16:08:29.845647    2293 round_trippers.go:463] GET https://kubernetes.docker.internal:6443/api/v1/namespaces/default/pods?limit=500
I0808 16:08:29.845656    2293 round_trippers.go:469] Request Headers:
I0808 16:08:29.845660    2293 round_trippers.go:473]     Accept: application/json;as=Table;v=v1;g=meta.k8s.io,application/json;as=Table;v=v1beta1;g=meta.k8s.io,application/json
I0808 16:08:29.845664    2293 round_trippers.go:473]     User-Agent: kubectl/v1.29.2 (darwin/arm64) kubernetes/4b8e819
I0808 16:08:29.863821    2293 round_trippers.go:574] Response Status: 200 OK in 18 milliseconds
NAME                        READY   STATUS    RESTARTS   AGE
nginx-app-5777b5f95-n945v   1/1     Running   0          10m
```
