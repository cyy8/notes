# notes
Linux learning notes

https://github.com/cyy8/notes


# 20240720 Linux 系统命令及Shell脚本实践指南
- 生成某个文件并添加特定内容 echo
```
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

grep
```
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

sort
```
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
```
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

uniq
```
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

cut截取文本，处理的对象是“一行”

```
创建文件 找出示例文件的前5行
cyy@mac g % cat /etc/passwd | grep ':'| head -n 5  
nobody:*:-2:-2:Unprivileged User:/var/empty:/usr/bin/false
root:*:0:0:System Administrator:/var/root:/bin/sh
daemon:*:1:1:System Services:/var/root:/usr/bin/false
_uucp:*:4:4:Unix to Unix Copy Protocol:/var/spool/uucp:/usr/sbin/uucico
_taskgated:*:13:13:Task Gate Daemon:/var/empty:/usr/bin/false
```

```
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

tr 文本替换
```
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

paste 文本合并

```
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
sed 
创建文件
```
this is line1,this is First line
this is line 2,the Second line,Empty line followed
this is line 4,this is Third line
this is line 5, this is Fifth line
```

```
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

awk 基于列的文本处理工具（与sed相对，sed是基于行的文本处理工具）

创建文本
```
john.wang   Male    30  021-11111111
lucy.wang   Female  25  021-22222222
jack.wang   Male    35  021-33333333
lily.wang   Female  20  021-44444444
```

```
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
```
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
```
cyy@mac ~ % pbpaste |tr '"' '\n' |grep http | grep https|cut -f1-3 -d'/'
https://pagead2.googlesyndication.com
https://schema.org
https://static.book345.com
```

## head 和 tail 查看文件的开头或结尾几行
```
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



# 20240715  Linux实操篇 实用指令
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


# pbpaste and pipe
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

# open from Terminal 

```
cd g/notes
code .
```



# 20240714  Learn Linux

git status; git add .; git commit -m "$( date "+%Y-%m-%d %T")"; git push


command+j open terminal

day 1 practice git


https://www.runoob.com/linux/linux-system-contents.html

https://www.runoob.com/linux/linux-file-attr-permission.html

https://www.runoob.com/linux/linux-file-content-manage.html


https://www.runoob.com/linux/linux-vim.html 

