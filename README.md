# notes
Linux learning notes

https://github.com/cyy8/notes

# 20240723 Linux 脚本学习（自学版）
## 变量：
变量命名：Shell中的变量必须以字母或下划线开头，后面可以跟数字、字母或下划线，变量长度没有限制。但要注意以下两类错误类型：
a. PS1 #变量不能和Shell的预设变量名重名  
b. for #变量不能使用Shell的关键字

## 定义变量：变量名=变量值
#注意1: 变量名和变量值之间用等号紧紧相连，之间没有任何空格；变量值也可以加引号（单双都可以）
```bash
cyy@mac notes %  name=john
cyy@mac notes % name = john
zsh: command not found: name
cyy@mac notes % name= jonh
zsh: command not found: jonh

cyy@mac notes % name='john'
cyy@mac notes % name="john"
```
#注意2: 变量值如果有空格，必须加引号，否则会报错
```bash
cyy@mac notes % name=john wang
zsh: command not found: wang

cyy@mac notes % name='john wang'
```

变量的取值：变量名前加上$符号，严谨一点的写法是 ${} 
```bash
cyy@mac notes % echo $name
john wang
cyy@mac notes % echo ${name}
john wang
```
#区分以下两种赋值：若要打印“sue Hello”，变量需按标准格式➕{},如果没有，Shell语法自动将等号后的内容解释为变量（sue Hello），又因“sue Hello”并未声明，所以值为空
```bash
cyy@mac notes % name='sue '
cyy@mac notes % echo $nameHello

cyy@mac notes % echo ${name}Hello
sue Hello
```
##由以上可知，Shell具有“弱变量性”，即在没有预先声明变量的时候也可以引用，且没有任何报错或者提醒，可能会造成脚本中引用不正确的变量，从而导致脚本异常但很难找出原因。在这种情况下，可以设置脚本运行时必须遵循“先声明再使用”的原则，这样一旦脚本中出现未声明的变量情况则会立刻报错：
```bash
cyy@mac notes % shopt -s -o nounset
zsh: command not found: shopt   ##问题
```

取消变量：unset
```bash
cyy@mac notes % name=john
cyy@mac notes % echo $name
john
cyy@mac notes % unset name
cyy@mac notes % echo $name
```

## 数组（Array）
定义数组：用declare定义数组Array, 第一个元素赋值为0，第二个为1，第三个元素：一个字符串 ##问题

数组可以在创建的同时赋值,增加/替换 ## 跟书上不一样呢？
```bash
cyy@mac notes % declare Score=('50' '70' '90')
cyy@mac notes % Score[2]='60'
cyy@mac notes % declare Score
Score=( 50 60 90 )
cyy@mac notes % declare Score=('50' '90')     
cyy@mac notes % Score[3]='100'
cyy@mac notes % declare Score            
Score=( 50 90 100 )
cyy@mac notes % Score[3]=('100' '120')
cyy@mac notes % declare Score         
Score=( 50 90 100 120 )
cyy@mac notes % Score[1]=('30' '40')  
cyy@mac notes % declare Score       
Score=( 30 40 90 100 120 )
```


## 引用
Shell中共有4种引用符，分别是双引号（部分引用或弱引用）、单引号（全引用或强引用）、反引号（将括起的内容解释为系统命令）、转义符（\）

部分引用：$、反引号（`）、转义符（\）依然会被解析为特殊意义
声明变量VARO3，第一次直接打印，第二次加双引号，输出没有区别
```bash
cyy@mac notes % VAR03=100
cyy@mac notes % echo $VAR03
100
cyy@mac notes % echo "$VAR03"
100
```
声明变量VAR04，加双引号与否，输出也没区别(与书上讲的不同)
```bash
cyy@mac notes % VAR04="A        B        C"
cyy@mac notes % echo "$VAR04"              
A        B        C
cyy@mac notes % echo $VAR04                
A        B        C
```

全引用：单引号中的任何字符都只当作是普通字符（除单引号本身，即单引号中间无法再单独包含单引号，用转义符也不可）。单引号中的字符只能代表其作为字符的字面意义：
```bash
cyy@mac notes % echo "$VAR03"
100
cyy@mac notes % echo '$VAR03'
$VAR03
```
如果全引用括起的字符串含有单引号，则会出现问题，需加转义符，或变单引号为双引号：
```bash
cyy@mac notes % echo 'It's a dog'   
quote> echo "It's a dog"     #quote啥意思
```

## 命令替换：1. `命令` 2. $(命令)
```bash
cyy@mac notes % DATE_01=`date`
cyy@mac notes % DATE_02=$(date)
cyy@mac notes % echo $ DATE_01  # $与命令间没有空格
$ DATE_01
cyy@mac notes % echo $DATE_01 
2024年 7月23日 星期二 13时47分47秒 CST
cyy@mac notes % echo $DATE_02
2024年 7月23日 星期二 13时48分03秒 CST
```

反引号可与 $() 等价，因反引号与单引号看起来类似，时常对差看代码造成困难，所以使用 $() 就相对清晰：
```bash
cyy@mac notes % LS=`ls -l`
cyy@mac notes % echo $LS
total 96
drwxr-xr-x  12 cyy  staff    384  7 20 23:19 0720-tmp-files
-rwxr-xr-x   1 cyy  staff     56  7 22 22:06 HelloWorld.sh
-rw-r--r--   1 cyy  staff   2498  7 17 13:42 IELTS.md

cyy@mac notes % LS=$(ls -l)
cyy@mac notes % echo $LS
total 96
drwxr-xr-x  12 cyy  staff    384  7 20 23:19 0720-tmp-files
-rwxr-xr-x   1 cyy  staff     56  7 22 22:06 HelloWorld.sh
-rw-r--r--   1 cyy  staff   2498  7 17 13:42 IELTS.md
```
另外，$() 支持嵌套，而反引号不行；$() 仅可在Bash Shell中有效，而反引号可在多种UNIX SHELL中使用。所以各有特点，选哪个看需要和个人喜好

## 运算符
算术运算符
```bash
cyy@mac notes % let I=2+2    #work
cyy@mac notes % echo $I
4
cyy@mac notes % let I=15/7  #work
cyy@mac notes % echo $I
2
cyy@mac notes % I=2+2       #work
cyy@mac notes % echo $I
4
cyy@mac notes % I=15/7      #work
cyy@mac notes % echo $I
2
cyy@mac notes % echo "$10%3"    #test
%3
cyy@mac notes % echo $10%3      #test
%3
cyy@mac notes % L=10%3          #not work
cyy@mac notes % echo $L
10%3
cyy@mac notes % echo "$L"       #not work
10%3
cyy@mac notes % let L=10%3      #work
cyy@mac notes % echo $L
1
cyy@mac notes % A=2*3           #test
cyy@mac notes % echo $A
2*3
cyy@mac notes % echo "$A"
2*3
cyy@mac notes % let A=2*3       #not work
zsh: no matches found: A=2*3
cyy@mac notes % let B=2*3
zsh: no matches found: B=2*3
```

位元算符存疑


使用$[]做运算：$[] 与 $(()) 类似，可用于简单的算术运算：
```bash
cyy@mac notes % echo $[1+1]
2
cyy@mac notes % echo $[2*2]
4
cyy@mac notes % echo $[5**2]
25
```
使用expr做运算：expr也可用于整数运算。与其他算数运算不同，expr要求操作数和操作符之间使用空格隔开（否则只会打印出字符串），所以特殊的操作符要使用转义符转义（如*）。
expr支持加减乘除余等：
```bash
cyy@mac notes % expr 1+1
1+1
cyy@mac notes % expr 1 + 1
2
cyy@mac notes % expr 2 * 2
expr: syntax error
cyy@mac notes % expr 2 \* 2
4
```

内建运算命令 declare
declare是shell的内建命令，通过它也能进行整数运算，但使用declare显示定义整数变量（-i 参数指定变量为“整数”），再进行赋值。如不定义，赋值“1+1”便是简单的字符串，与“1+1”无异：
```bash
#不用declare定义变量
cyy@mac notes % S=1+1
cyy@mac notes % echo $S
1+1
#用declare定义变量
cyy@mac notes % declare -i J
cyy@mac notes % J=1+1
cyy@mac notes % echo $J
2

#注意，Shell中的算术运算要求 运算符和操作数之间不能有空格；特殊符号也不需要转义；算术表达式中含有其他变量也不需要用$引用。
```

算术扩展：shell内建命令之一，整数变量的运算机制，基本语法：
$((算术表达式))
其中，算术表达式由变量和运算符组成，常见的用法是显示输出和变量赋值。若表达式中的变量没有定义，则计算时，其值会被假设为0（但不会真的因此赋0值给该变量）：
```bash
cyy@mac notes % i=2
cyy@mac notes % echo $((2*i+1))
5
cyy@mac notes % echo $((2*(i+1)))   #用括号改变运算优先级
6

#变量赋值
cyy@mac notes % var=$((2*i+1))
cyy@mac notes % echo $var
5

#未定义的变量参与算术表达式求值 （默认为0）
cyy@mac notes % var=$((2*j+1))   
cyy@mac notes % echo $var
1
```

## 通配符









# 20240722 Linux Shell脚本学习
## 简单脚本的创建和执行 第一个shell脚本：输出 hello world
1. 创建文件：cyy@mac notes % code HelloWorld.sh
Shell脚本永远以“#!”开头，这是一个脚本开始的标记，表示系统执行这个文件需要使用某个解释器（常见的解释器有sh、bash），后面的/bin/bash指明了解释器的具体位置
```bash
cyy@mac notes % cat HelloWorld.sh
#!/bin/bash   
#This line is a comment
echo "Hello World"
```
2. 运行脚本：
第一种: bash + 脚本
```bash
cyy@mac notes % bash HelloWorld.sh 
Hello World
```
第二种：添加可执行权限（chmod +x ➕脚本），然后使用“./”运行
```bash
cyy@mac notes % ./HelloWorld.sh
zsh: permission denied: ./HelloWorld.sh
cyy@mac notes % chmod +x HelloWorld.sh 
cyy@mac notes % ./HelloWorld.sh 
Hello World
```

## if 语句
if➕空格 [空格 "……" 空格];空格 then
```bash
#!/bin/bash
SCORE=70
if [ "$SCORE" -lt 60 ]; then
echo "C"
fi
```
if/esle语句
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
基础版
```bash
#!/bin/bash
for i in a b c d 1 2 3
do 
    echo $i
done
```

加if/else版
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

seq,输出序列
```bash
cyy@mac notes % seq 3
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

“$(命令)”表示获取该命令的结果 to get the result of the command
```bash
cyy@mac notes % for i in $(ls)
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
两种读取文件的方式：
第一种 done后接重定向
```bash
#! /bin/bash
while read line
do 
    echo $line | wc -c
    echo
done < learnif.sh
```
第二种 while前用cat+管道
```bash
cat learnif.sh | while read line
do 
    echo $line | wc -c
    echo
done 
```


wc表示统计文件的行数（-l）、单词数（-c）和大小
```bash
cyy@mac notes % wc quiz.sh   
       5       9      48 quiz.sh
cyy@mac notes % wc -l quiz.sh
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








# 20240720 Linux 系统命令及Shell脚本实践指南
- 生成某个文件并添加特定内容 echo
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

grep
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

sort
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

uniq
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

cut截取文本，处理的对象是“一行”

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

tr 文本替换
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

paste 文本合并

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
sed 
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

awk 基于列的文本处理工具（与sed相对，sed是基于行的文本处理工具）

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

