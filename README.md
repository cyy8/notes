# notes 

* My GitHub：https://github.com/cyy8/notes
* golang: https://go.dev/tour/basics/1
* [中文技术文档的写作规范](https://github.com/ruanyf/document-style-guide/tree/master?tab=readme-ov-file)
* [Hyphen vs. Dash – – — What’s the Difference?](https://www.grammarly.com/blog/hyphens-and-dashes/)
* [Kubernetes Contributor Cheat Sheet](https://github.com/kubernetes/community/tree/master/contributors/guide/contributor-cheatsheet)
* [Your First Contribution](https://github.com/kubernetes/community/blob/master/contributors/guide/first-contribution.md)

# Day 26 - 20240814

- 泛读《Go语言 从入门到项目实战》 2h
- 中式英语之鉴 

## 《Go语言 从入门到项目实战》 

- Chapter 4 流程控制语法 *冒泡排序
- Chapter 5 函数  *函数调用、闭包及以后
- Chapter 6 结构体 *方法与接收者

# Day 25 - 20240813

- 泛读《Go语言 从入门到项目实战》 2.5h

Chapter 1-3，目前读下来可理解85%左右，新手友好，正文里稍微有不懂的地方后面会有注释解释，比之前的 Head first Go 清晰易懂

- 中式英语之鉴 1.5h
- Linux基金会了解
- k8s文档学习


# Day 24 - 20240812

- 周一图书馆闭馆，在家休息；看k8s文档考古

# Day 23 - 20240811

* 《每天5分钟玩转Kubernetes》 2.5h 
* [Open Source Technical Documentation Essentials (LFC111)](https://trainingportal.linuxfoundation.org/courses/open-source-technical-documentation-essentials-lfc111) 1h

## Open Source Technical Documentation Essentials (LFC111) 

### A technical writer needs to

- Focus on the user viewpoint
- Present the information that specific types of users need to perform specific tasks
- Balance the factual information that users need to perform tasks with the conceptual information they need to understand when and how to perform those tasks

### Identifying the audience and their needs
Each document and each section in each document should make clear：
- Who is the intended audience for the information
- What background they are expected to have
- Where they can go to get that background
- How to expect the to use the information


# Day 22 - 20240810

* 《每天5分钟玩转Kubernetes》 3h 
* [Workload Management in K8s](https://kubernetes.io/docs/concepts/workloads/controllers/) 1h


# Day 21 - 20240809

* 《中式英语之鉴 》3h
* k8s文档学习 2h

## k8s文档学习

https://kubernetes.io/docs/concepts/overview/working-with-objects/#kubernetes-objects

https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

https://kubernetes.io/docs/concepts/workloads/controllers/deployment/


# 第一次给 Kubernetes 开源社区做贡献

20240808 学习 IT 技术的第20天，开始了解 K8s 的第一天，浏览了官方文档，并提了一个小小的PR。

这也是我第一次提交 Pull Request 啊，第一次给开源社区做贡献! 

https://github.com/kubernetes/website/pull/47399

>Welcome @cyy8!  
>It looks like this is your first PR to kubernetes/website 🎉.  
>…  
>Thank you, and welcome to Kubernetes. 


# Day 20 - 20240808

## [Kubernetes (K8s)](https://kubernetes.io/docs/concepts/architecture/)

《Kubernetes 快速入门（第2版）》 

# Day 19 20240807

* Linux 《Linux Shell 脚本攻略（第3版）》2.5h
* 《《中式英语之鉴 》2h

# Day 18 20240806

* 《中式英语之鉴 》2.5h
    * Part One - Unnecessary Nouns and Verbs

* Go
    * 函数或方法多个返回值 没太看懂

# Day 17 20240805

* Linux Working with Files & Text Processing 2.5h
* Go 1h

# Day 16 20240804

阿里云 Aliyun 4h

# Day 15 20240803

Vim/Vi 编辑器 2h


# Day 14 20240801 

给产品经理讲技术 2h
Linux 3h （ - File permissions）

# Day 13 20240731 

Head First Go语言程序设计 (见golang.md)

## 图解HTTP （继续复习）

- Chapter 5
- Chapter 6 HTTP 首部
- Chapter 7 HTTPS
- Chapter 10 - 前端知识？有点跳
（本书结束）


# Day 12 20240730 
 
[Markdown学习](https://www.markdowntutorial.com/lesson/1/) （2h）

## 图解HTTP
how to read this book：skip chapter 5、8、9、11，skim chapter 6

# Day 11 20240729

## 网络是怎么连接的 （40 min）

how to read this book：focus on chapter 1；skim the rest （skip the charts and pictures，try to understand concepts）

（本书Chapter1内容结束）

##  Linux 系统命令及Shell脚本（16:40-17:30） 
how to read this book：
1. chapter 6 网络管理 ifconfig dns ping（见0727） 
2. chapter 7 进程管理（整章）


# Day 10 20240728
每天5分钟玩转docker  
read Chapter 2、3、4；the rest not now

# Day 9 20240727

>Roadmap  
>curl  ->  http  ->   dns  ->   tcp/ip   网络

# Day 8 20240726 

《计算机网络》 谢希仁

# Day 7 20240725

《UNIX/LINUX/OS X中的Shell编程》 人民邮电出版社

# Day 6 20240724 

Linux 脚本学习（自学版）

UNIX/LINUX/OS X中的Shell编程》 人民邮电出版社 开始学习

# Day 5 20240723 
Linux 脚本学习（自学版）

# Day 4 20240722 
Linux Shell脚本学习

# Day 3 20240720 
Linux 系统命令及Shell脚本实践指南

# Day 2 20240715  

Linux实操篇 实用指令
pbpaste and pipe

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

```
cd g/notes
code .
```

# Day 1 20240714 
Learn Linux 

* git status; git add .; git commit -m "$(date "+%Y-%m-%d %T")"; git push

* command+j open terminal

day 1 practice git

https://www.runoob.com/linux/linux-system-contents.html

https://www.runoob.com/linux/linux-file-attr-permission.html

https://www.runoob.com/linux/linux-file-content-manage.html

https://www.runoob.com/linux/linux-vim.html 
