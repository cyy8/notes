# notes
Linux learning notes

https://github.com/cyy8/notes


### 练习：提取某个网址对应的IP地址
```bash
nslookup abc.com | grep 'Address'| grep -v '#'| cut -f2 -d' '| tr '\n' ' '
99.84.133.46 99.84.133.97 99.84.133.98 bash-3.2$ 

#nslookup 关键词待搜索 DNS dig http
#grep 获取含有Address的行，并删除带有#的行
#cut 以空格为分隔符，提取第二列
#tr 将换行替换为空格，合并为一行 
```

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

# Day 7 20240725

UNIX/LINUX/OS X中的Shell编程》 人民邮电出版社

## Chapter 2 什么是Shell
内核和实用工具：Unix系统在逻辑上被划分为内核和实用工具（Utility），通常来说，所有的访问都要经过Shell。
内核是Unix系统的核心所在，内核位于计算机的内存中；组成Unix的各种实用工具位于计算机磁盘中，需要的时候会被加载到内存并执行。

### Shell的功能
1. 程序执行：Shell负责执行终端中指定的所有程序。
    每次输入一行内容（正式名称：命令行），Shell会扫描命令行，确定要执行的程序名称及所传入的程序参数。

    Shell会使用一些特殊字符确定程序名称及每个参数的起止，这些字符统称为空白字符（whitespace characters），包括空格符、水平制表符和行尾符（又叫换行符）。连续多个空白会被Shell忽略。

```bash
mv tmp/mazewars games 
#Shell会扫描该命令行，提取到 行首 到 第一个空白字符之间的所有命令作为待执行的程序名称：mv。随后的空白字符（多余的空格）会被忽略。
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
#### 点号（.）：匹配任意单个字符
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

#### 脱字符（^）：匹配行首
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

#### 美元符号（$）：匹配行尾
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
^和$组合使用：
```bash
^$ #匹配空行
^ $ #匹配单个空格组成的行
```

#### 英文省略号（[...]）：匹配字符组
```bash
[0-9]   #匹配0-9之间的任意数字
[A-Z]   #匹配大写字母
[A-Za-z]    #匹配大写和小写字母
[^A-Z]      #匹配大写字母以外的任意字符 相当于Shell中的感叹号！
```

#### 星号（*）：匹配零个或多个字符
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

#### \{...\}：匹配固定次数的子模式
```bash
\{min,max\}  #min指待匹配的正则表达式需要出现的最小次数，max则为最大次数；且必须用\对花括号进行转义
X\{1,10\}    #指能匹配1-10个连续的X
[A-Za-z]\{4,7\} #匹配4-7之间的字母字符序列
\{10\}  #花括号之间只有一个数字，表示正则表达式必须匹配的次数
[a-zA-Z]\{7\}       #能够匹配7个字母字符
.\{10\}     #能够匹配10个任意字符
+\{5,\}     #花括号单个数字紧跟一个逗号，表示至少匹配5次，最多不限。 此处指匹配至少5个连续的+
```

#### \(...\)：保存已匹配的字符
有点太复杂了，先马一下好了


# Day 6 20240724 

Linux 脚本学习（自学版）

## while循环
结构
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

用while循环计算1-100之和、1-100奇数之和
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

用while做猜数字游戏，只有输入的数字和预设数字一致时，才会停止循环：
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

while 结合 awk 按行读取文件，输出信息，两种方式：
```bash
#创建文件
John 30 Boy
Sue 28 Girl
Wang 25 Boy 
Xu 23 Girl
```
第一种(重定向)：
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
第二种（管道）：
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
until是测试假值的方式（与while相对），直到测试为真时才停止循环，其语法结构与while一致：
```bash
until expression
do
    command
done
```

计算1-100之和、1-100奇数之和：
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

# 《UNIX/LINUX/OS X中的Shell编程》 人民邮电出版社 开始学习
## Chapter 1 基础概述
### date命令：显示日期和时间
```bash
➜  ~ date
2024年 7月24日 星期三 15时33分35秒 CST
```
### who命令：找出已登录人员
```bash
➜  ~ who
cyy              console       7  3 22:17 

#也可以获取本人信息
➜  ~ who am i
cyy                            7 24 15:35 
```
### echo命令：回显字符
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
### ls命令：查看目录下的文件
### cat命令：检查文件内容 concatenate
```bash
➜  notes git:(main) ✗ cat forlist.sh
#! /bash/bin
for VAR in {1..5}
do
    echo "Loop $VAR times"
done%  
```
### wc命令：统计文件中单词数量
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
### 命令选项 -，后面直接跟字母
如要计算文件中包含的行数，可以用“wc -l”; 字符数可以用 -c选项；单词数 -w选项
```bash
➜  g wc -l ls_usr.txt  #-l选项 行数
       4 ls_usr.txt
➜  g wc -c ls_usr.txt  #-c选项 字符数
     163 ls_usr.txt
➜  g wc -w ls_usr.txt  #-w选项 单词数
      29 ls_usr.txt
```

### cp命令：复制文件
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
### mv命令：文件重命名/移动
重命名
```bash
mv old_name new_name
```
```bash
➜  g ls
ls_no_usr.txt ls_usr.txt    notes         sayHello.sh   sort.txt      testhello.txt uniq.txt
➜  g mv sort.txt sortmv.txt
➜  g ls
ls_no_usr.txt notes         sortcp.txt    testhello.txt
ls_usr.txt    sayHello.sh   sortmv.txt    uniq.txt
```

移动
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

### rm命令：删除文件
```bash
rm names
```
rm也可以一次性删除多个文件，空格隔开即可

### mkdir命令：创建目录
### 目录之间复制(cp)、移动（mv）文件
```bash
cp oldd/name1 newd/name2 
#同级目录格式

#因为在不同目录中，名字可以相同，此时可以仅指定目录：
cp oldd/name1 newd
```
### ln命令：文件链接
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

### rmdir命令：删除目录 有危险不用
### 文件名替换 星号 *
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
### 匹配单个字符
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
### 空格问题
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
### 标准输入
sort 排序不work  #待修正

# Day 5 20240723 Linux 脚本学习（自学版）
## 变量：
变量命名：Shell中的变量必须以字母或下划线开头，后面可以跟数字、字母或下划线，变量长度没有限制。但要注意以下两类错误类型：
a. PS1 #变量不能和Shell的预设变量名重名  
b. for #变量不能使用Shell的关键字

## 定义变量：变量名=变量值
#注意1: 变量名和变量值之间用等号紧紧相连，之间没有任何空格；变量值也可以加引号（单双都可以）
```bash
cyy@mac %  name=john
cyy@mac % name = john
zsh: command not found: name
cyy@mac % name= jonh
zsh: command not found: jonh

cyy@mac % name='john'
cyy@mac % name="john"
```
#注意2: 变量值如果有空格，必须加引号，否则会报错
```bash
cyy@mac % name=john wang
zsh: command not found: wang

cyy@mac % name='john wang'
```

变量的取值：变量名前加上$符号，严谨一点的写法是 ${} 
```bash
cyy@mac % echo $name
john wang
cyy@mac % echo ${name}
john wang
```
#区分以下两种赋值：若要打印“sue Hello”，变量需按标准格式➕{},如果没有，Shell语法自动将等号后的内容解释为变量（sue Hello），又因“sue Hello”并未声明，所以值为空
```bash
cyy@mac % name='sue '
cyy@mac % echo $nameHello

cyy@mac % echo ${name}Hello
sue Hello
```
##由以上可知，Shell具有“弱变量性”，即在没有预先声明变量的时候也可以引用，且没有任何报错或者提醒，可能会造成脚本中引用不正确的变量，从而导致脚本异常但很难找出原因。在这种情况下，可以设置脚本运行时必须遵循“先声明再使用”的原则，这样一旦脚本中出现未声明的变量情况则会立刻报错：
```bash
cyy@mac % shopt -s -o nounset
zsh: command not found: shopt   ##问题
```

取消变量：unset
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

反引号可与 $() 等价，因反引号与单引号看起来类似，时常对差看代码造成困难，所以使用 $() 就相对清晰：
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
另外，$() 支持嵌套，而反引号不行；$() 仅可在Bash Shell中有效，而反引号可在多种UNIX SHELL中使用。所以各有特点，选哪个看需要和个人喜好

## 运算符
算术运算符
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

位元算符存疑


使用$[]做运算：$[] 与 $(()) 类似，可用于简单的算术运算：
```bash
cyy@mac % echo $[1+1]
2
cyy@mac % echo $[2*2]
4
cyy@mac % echo $[5**2]
25
```
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

内建运算命令 declare
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

算术扩展：shell内建命令之一，整数变量的运算机制，基本语法：
$((算术表达式))
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

```bash
通配符用于模式匹配，常见的通配符有*、？和[]括起来的字符序列。其中：
*代表任意长度的字符串，但不包括点号和斜线号，也就是a*无法匹配abc.txt。
？可用于匹配任何一个单一字符。
[]代表匹配其中的任意一个字符，如[abc]表示可以匹配a或者b或者c；[]中可以用 - 表明起止，如[a-c]等同于[abc]
但注意， - 在[]外只是一个普通字符，没有任何特殊作用；*和？在[]中则变成了普通字符，没有通配的功效
```

大括号：匹配多个排列组合的可能
```bash
cyy@mac % echo {x1,x2}{y1,y2}
x1y1 x1y2 x2y1 x2y2
```

## 测试
$?:判断文件是否存在
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
#！expression （逻辑测试）表示如果expression为真，则测试结果为假
#expression 1 -a expression 2 （逻辑测试）表示expression 1和2同时为真，则测试结果为真 （逻辑运算：&&）
#expression 1 -o expression 2 （逻辑测试）表示expression 1和2只要有1个为真，则测试结果为真（逻辑运算：||）

#-eq 等于；
#-gt great than 大于 
#-lt less than 小于
#-ge great equal 大于等于
#-le less equal 小于等于
#-ne not equal 不等于


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

### 结合seq命令针求和
1-100求和
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
求1-100奇数的和
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


# Day 4 20240722 Linux Shell脚本学习
## 简单脚本的创建和执行 第一个shell脚本：输出 hello world
1. 创建文件：cyy@mac % code HelloWorld.sh
Shell脚本永远以“#!”开头，这是一个脚本开始的标记，表示系统执行这个文件需要使用某个解释器（常见的解释器有sh、bash），后面的/bin/bash指明了解释器的具体位置
```bash
cyy@mac % cat HelloWorld.sh
#!/bin/bash   
#This line is a comment
echo "Hello World"
```
2. 运行脚本：
第一种: bash + 脚本
```bash
cyy@mac % bash HelloWorld.sh 
Hello World
```
第二种：添加可执行权限（chmod +x ➕脚本），然后使用“./”运行
```bash
cyy@mac % ./HelloWorld.sh
zsh: permission denied: ./HelloWorld.sh
cyy@mac % chmod +x HelloWorld.sh 
cyy@mac % ./HelloWorld.sh 
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

“$(命令)”表示获取该命令的结果 to get the result of the command
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








# Day 3 20240720 Linux 系统命令及Shell脚本实践指南
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



# Day2 20240715  Linux实操篇 实用指令
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



# Day 1 20240714  Learn Linux 

git status; git add .; git commit -m "$( date "+%Y-%m-%d %T")"; git push


command+j open terminal

day 1 practice git


https://www.runoob.com/linux/linux-system-contents.html

https://www.runoob.com/linux/linux-file-attr-permission.html

https://www.runoob.com/linux/linux-file-content-manage.html


https://www.runoob.com/linux/linux-vim.html 

