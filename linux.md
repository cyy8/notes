# Day 3 20240807 

## 《Linux Shell 脚本攻略（第3版）》2.5h
### Chapter 1
- 终端显示
    - `$` 表示普通用户
    - `#` 表示管理员用户root
- echo
```sh
bash-3.2$ echo hello !
hello !
bash-3.2$ echo 'hello !'
hello !
bash-3.2$ echo "hello !"
bash: !": event not found  #双引号内的特殊字符需要转义
bash-3.2$ echo "hello \!" ##打印出来是什么鬼
hello \!
```
- `echo -e` 表示包含转义序列字符串
```sh
echo -e "\e[31mThis is red text\e[0m"  ## what's wrong 解答：换iterm
```

- printf
    - 格式化字符串：指定字符串的宽度、左右对齐方式等
    - 工作原理
```sh
#!/bin/bash
printf "%-10s %10s %-4s\n" No Name Mark     # `%-5`表示左对齐且宽度为5的字符串，如果不指明`-`，默认右对齐
printf "%-10s %10s %-4s\n" Therefore Name Mark
printf "%c\n%s\n%d\n" able able 8   # `%c`输出一个字母 `%s`输出一个字符串 `%d` 输出一个整数
printf "%.2f\n" 7       # `%.2f`输出一个浮点数，并保留2位小数
printf "hello ?\n"      # `\n`换行符
printf "hello \"\n"     # `\`转义符

# 输出结果
No               Name Mark
Therefore        Name Mark
a
able
8
7.00
hello ?
hello "
```

- 变量赋值
```sh
#!/bin/bash
fruit=apple count=5 
# fruit是变量名，apple是赋给变量的值，如果value不包含空白字符，就不需要加引号，否则要加单引号或双引号
# 赋值等号前后没有空格
echo "We have $count ${fruit}s"
# `echo $var`可以访问变量的内容，或者`echo ${var}`

# 输出结果
We have 5 apples
```

- length 获取字符串长度
```sh
echo ${#var}

bash-3.2$ var=123456
bash-3.2$ echo ${#var}
6
```

- 识别当前Shell的版本
`echo $SHELL` or `echo $0`
```sh
bash-3.2$ echo $SHELL
/bin/zsh
```

1.4跳过

- let 命令（只限整数）
    - let命令可以执行基本的算术操作
```sh
n1=2 n2=4
bash-3.2$ result=n1+n2      #不加let，直接输出原公式
bash-3.2$ echo $result      
n1+n2
bash-3.2$ let result=n1+n2  #加let，执行了算数操作
bash-3.2$ echo $result
6
bash-3.2$ 
```

expr没明白

- bc 可执行浮点数运算
```sh
bash-3.2$ echo "0.56*3"
0.56*3
bash-3.2$ echo "0.56*3"|bc
1.68
```
```sh
bash-3.2$ no=5
bash-3.2$ result=`echo "$no*3.5"|bc`
bash-3.2$ echo $result
17.5
```
```sh
bash-3.2$ echo "scale=5;11/3"|bc       
3
bash-3.2$ echo "scale=5;20/3"|bc
6
```
- Tee
```sh
bash-3.2$ echo "Good" | tee tee.txt | cat -n    # 将标准输出作为标准输入，并写入文件，一般是覆盖
     1  Good
bash-3.2$ cat tee.txt | tee -a tee.txt  # -a 表示追加内容
Good
bash-3.2$ cat tee.txt 
Good
Good
```

1.6.4 、1.7 1.10 1.11 1.12 1.14跳过

- alias 别名
    - `echo 'alias cmd="command seq"'>>~/.bashrc` 将alias定义到`~/.bashrc`文件中，可使其一直有效
    - 如需删除，可以将`~/.bashrc`文件删除，或用`unalias`
    - zsh 时，对应 `~/.zshrc` 文件


# Day 2 20240805 3h

## Working with files
### Archiving and Compressing
- Archiving `tar`
    - `tar`, originally for taping archiving
    -  -cf archive.tar foo bar  # Create archive.tar from files foo and bar.
    -  -tvf archive.tar         # List all files in archive.tar verbosely.
    -  -xf archive.tar          # Extract all files from archive.tar.
- Compressing `gzip` or `bzip2`
    -`gzip` or `bzip2`, used for file compression，reducing the file size and making data transmission easier
    - -c stardard output
    - -1 compress faster
    - -9 compress better

```sh
root@cyy-ecs:~/linux-test-files# tar -cf archive.tar tat2.txt test.txt
root@cyy-ecs:~/linux-test-files# ls -l
total 20
-rw-r--r-- 1 root root 10240 Aug  5 14:41 archive.tar #打包文件原始大小
-rw-r--r-- 1 root root   644 Aug  5 14:26 tat2.txt
-rw-r--r-- 1 root root   816 Aug  5 14:30 test.txt

root@cyy-ecs:~/linux-test-files# gzip archive.tar
root@cyy-ecs:~/linux-test-files# ls -l
total 12
-rw-r--r-- 1 root root 1191 Aug  5 14:41 archive.tar.gz  #打包文件大小被压缩了很多
-rw-r--r-- 1 root root  644 Aug  5 14:26 tat2.txt
-rw-r--r-- 1 root root  816 Aug  5 14:30 test.txt
```
### Copying and Renaming files
- `cp`: copy command
    - cp /path/to/original/file /path/to/copied/file
- `mv`: rename or move  
    - mv /path/to/original/file /path/to/new/file
```sh
�Y�	EQn�(root@cyy-ecs:~/linux-test-files# ls
archive.tar  archive.tar.gz  tat2.txt  test.txt
root@cyy-ecs:~/linux-test-files# cp tat2.txt tat3.txt #复制tat2.txt并命名为tat3.txt
root@cyy-ecs:~/linux-test-files# ls
archive.tar  archive.tar.gz  tat2.txt  tat3.txt  test.txt 
root@cyy-ecs:~/linux-test-files# mv test.txt tat4.txt   #重命名test.txt为tat4.txt
root@cyy-ecs:~/linux-test-files# ls
archive.tar  archive.tar.gz  tat2.txt  tat3.txt  tat4.txt
```

### Soft and Hard links
- In Unix-like operating system, soft and hard links are simply references to existing files that allow users to create shortcuts and duplication effects within their file system
- hard links
    - a **mirror reflection** of the original file, sharing the same file data but displaying a different name and inode number
    - the original file is deleted, the hard link still retains the file data
    - `ln source_file.txt hard_link.txt`
- soft links (also symbolic link)
    - more like a **shortcut** to the original file
    - `ln -s source_file.txt soft_link.txt` 

## Text Proccessing
### awk(基于列的文本处理工具，与sed相对)
- `awk`reads an input file line by line, identifies patterns that match what is specified in the script
- `awk '{print $1,$2}' filename`

### grep
- search for the specified pattern within the file and prints the line to the terminal
- `grep 'pattern' filename`

### uniq
- comparing or filtering out repeated lines that are adjacent
- only removes duplicates that are next to each other
- mostly, `sort`first, then `uniq`
- `sort names.txt | uniq`
```sh
root@cyy-ecs:~/linux-test-files# cat tat0.txt
abc
cba
cbc
abc
cbc
123
456
123
root@cyy-ecs:~/linux-test-files# sort tat0.txt | uniq
123
456
abc
cba
cbc
```
### unexpand & expand
- unexpand：convert **spaces** to **tabs**
- `unexpand -t 4 file.txt`  # '-t 4' means to replace every 4 spaces in file.txt with 1 tab
- expand：convert **tabs** to **spaces** 
- `expand filename` by default converts tabs into 8 spaces
- `expand -t 4 file.txt`    # '-t 4' means to replace every 1 tab in file.txt with 4 spaces
```sh
root@cyy-ecs:~/linux-test-files# unexpand -t tat0.txt
unexpand: tab size contains invalid character(s): ‘tat0.txt’        #咋回事
root@cyy-ecs:~/linux-test-files# cat tat0.txt
abc    abc   789
cba   123   567
cbc
abc
cbc
123
456
123

root@cyy-ecs:~/linux-test-files# unexpand -t tat0.txt
unexpand: tab size contains invalid character(s): ‘tat0.txt’

root@cyy-ecs:~/linux-test-files# unexpand  tat0.txt
abc    abc   789
cba   123   567
cbc
abc
cbc
123
456
123
```

### wc 
- `wc` means 'word count',count the number of bytes, characters, words, and lines in a file
- `wc filename.txt`

### nl
- `nl` means 'number lines'
- by default, `nl` only number the non-empty lines
- `nl [options] [filename]`
```sh
root@cyy-ecs:~/linux-test-files# cat expand.txt
abc     abc     789
cba             123             567
cbc     abc
cbc
123
456
123

root@cyy-ecs:~/linux-test-files# man wc
root@cyy-ecs:~/linux-test-files# wc -l expand.txt
12 expand.txt           # 加空行
root@cyy-ecs:~/linux-test-files# nl expand.txt
     1	abc	abc	789
     2	cba		123		567
     3	cbc	abc
     4	cbc
     5	123
     6	456
     7	123             # 默认不加空行
``` 

### Tee
- The command reads from the standard input and writes to standard output and files. 

```sh
➜  learn-go git:(main) ✗ echo hi | tee t.txt    
hi
➜  learn-go git:(main) ✗ cat t.txt 
hi
```

### Pipe
- `|` used to connect two or more commands together, allowing output of one command to be “piped” as input to another
- Example `ls | grep .txt` # 列出当前目录所有的txt文件

### Split
- `split` split large files into smaller files
- `split -l 3 filename`, 按行，每3行一个文件split
```sh
root@cyy-ecs:~/linux-test-files# split -l 3 expand.txt
root@cyy-ecs:~/linux-test-files# ls
archive.tar  archive.tar.gz  expand.txt  tat0.txt  tat3.txt  tat4.txt  tat5.txt  tat6.txt  xaa  xab  xac  xad
# xaa xab xac xad 为split的结果
```

### join
- `join` combine lines of 2 files on a common field
- `join file1.txt file2.txt`
```sh
root@cyy-ecs:~/linux-test-files# cat join.txt
a 1 2 3
d 4 5 6
g 7 8 9
root@cyy-ecs:~/linux-test-files# cat join2.txt
a b c
d e f
g h i
root@cyy-ecs:~/linux-test-files# join join.txt join2.txt
a 1 2 3 b c
d 4 5 6 e f
g 7 8 9 h i
```

### head/tail
- `head` allows a user to output the head of files; `tail` the tail of files
- `head -n 3 file.txt` `tail -n 3 file.txt`

### tr
- to substitute
- Example
```sh
root@cyy-ecs:~/linux-test-files# echo HELLO | tr 'A-Z' 'a-z'
hello
```

### sort
- basic usage: `sort file.txt`
- `sort` prints the sorted content of the file, the original remains unchanged
- To save the sorted contents back to the file, use redirection
    `sort file.txt > file2.txt`

### Paste
- `paste` column by column
```sh
root@cyy-ecs:~/linux-test-files# cat xaa
abc	abc	789
cba		123		567
cbc	abc
root@cyy-ecs:~/linux-test-files# cat xab
cbc
123
456
root@cyy-ecs:~/linux-test-files# paste xaa xab > xaabb.txt 
abc	abc	789	cbc
cba		123		567	123
cbc	abc	456
``` 
- 区分join、Paste
 - join：指定栏位相同的行连接起来
 - paste：合并文件的列

### Cut
- `cut` to cut out  sections of each line from a file or output
- Example, `-d`后接分隔符；`-f`后接输出第几列
```sh
root@cyy-ecs:~/linux-test-files# echo "one;two;three;four;five"|cut -d";" -f 2
two
root@cyy-ecs:~/linux-test-files# echo "one;two;three;four;five"|cut -d";" -f 1-2
one;two
root@cyy-ecs:~/linux-test-files# echo "one;two;three;four;five"|cut -d";" -f 3,5
three;five
```
## Server and review
### Uptime and Load
- uptime: show how long system has been running
```sh
➜  ~ uptime
11:42  up 34 days, 13:25, 5 users, load averages: 1.78 1.82 1.92
```

# Day 1 20240801 3h

## Navigation basics

### Basic commands
* cd: change directory
```bash
➜  notes git:(main) ✗ pwd
/Users/cyy/g/notes
➜  notes git:(main) ✗ cd /Users/cyy/g/notes/learn-linux
➜  learn-linux git:(main) ✗ pwd
/Users/cyy/g/notes/learn-linux
```
* ls: lists files and directories in the current directory
* pwd: View current working directory
* man ls: display the mannual page for a command
### Moving files
* mv moving files
```sh
mv [options] source destination
```
### Creating files
* touch: create an empty file/directory
```sh
touch newNamefile
```
* echo: make a file  with some text inside  
    * ps. the basic use of ehco is to print
```sh
echo [strings] > newNamefile

➜  learn-linux git:(main) ✗ echo "good to see you" > test3.md # test3.md 本不存在，
➜  learn-linux git:(main) ✗ cat test3.md  
good to see you
```
* cat: to type directly in to a new file 
    * ps. the basic use of cat is to show text 
```sh
➜  learn-linux git:(main) ✗ cat > test4.md
It's so good to see you again cat
^D          # contrl+D
➜  learn-linux git:(main) ✗ cat test4.md
It's so good to see you again cat
```
### Deleting files
* rm: delete a file
* rmdir: delete an empty directory

### Directory Hierarchy
* `/`: root directory, the top level of the file system
* `/home`: user home directories
* `/bin`: essential binary executables
* `/sbin`: system administration binaries   [#not familiar]
* `/etc`: configuration files
* `/var`: variable data(logs, spool files)
* `/usr`: User programs and data
* `/lib`: shared libraries
* `/tmp`: temporary files

## Editing files
### Vim
只学习基础简单命令，鼠标移动，删除行等。

## Shell and Other basics
### Command Path
* command path is a variable that used by the shell to determine where to look for the executable files to run.
### Environment Variables
* `env`：list all environment Variables
* `echo $PATH`: print a particular variable like PATH    # CDPATH 没太懂
### Command Help
* `man [command]`: view the manual for any command
* `help [command]`: for built-in shell functions
### Redirects in Shell basics
* Standard input: <
* Standard output: >
* Standard error
* pipe: |
### Super User
* also called "root user"
* `su`: swithces the current user to the root
```sh
su -
```
* `sudo`: allows you to run a command as another user, defaulting root
```sh
sudo [command]
```
## Working with files
### File Permissions
* permissions for files
    * read(r): can view or copy file contents
    * write(w): can modify content
    * execute(run, x): can run the file(if it is executable)
* permissions for directories
    * read(r): can list all files and copy them from directory
    * write(w): can add or delete files into directory(needs execute permission as well)
    * execute(run, x): can enter the directory
* 3 types of users: onwers, groups, others
* Understand file permissions and ownership 
    - File type: denotes the type of file
        - d: directory
        - -: regular file
    - Permissions: 
        - read(r)
        - write(w)
        - execute(run, x)
        - no permission set(-)
    - Hard link count: show if the file has hard links. Default count is one.
    - User
    - Group: the group that has access to this file.
    - File Size
    - Modification time
    - Filename

|File type    |Permissions    |Hard Link Count   |User Owner     |
|:---------:|:------------:|:------------:|:-----------:|
|d|rwxr-xr-x|1|cyy|  

Group Owner|File Size|Modification Timestamp|File Name|  
|:-------:|:----------:|:---------:|:---------:|
|staff|4192|7 14 21:14|HelloWorld.sh|

```bash
bash-3.2$ ls -l
drwx------@ 131 cyy   staff    4192  8  1 10:05 Downloads
-rwxr-xr-x@   1 cyy   staff      29  7 14 21:14 HelloWorld.sh
```
### Change file permissions (2 ways with `chmod`)
* Absolute mode
    * permissions represented in numeric form
        - r=4
        - w=2
        - x=1
        - -=0
    so 3(i.e. 2+1)=-wx; 5(i.e. 4+1)=r-x; 6(i.e. 4+2)=rw-; 7(i.e. 4+2+1)=rwx

```sh
bash-3.2$ chmod 667 HelloWorld.sh

-rw-rw-rwx@   1 cyy   staff      29  7 14 21:14 HelloWorld.sh
```

* Symbolic mode
    - owners denoted in the following symbols
        - u = user owner 
        - g = group owner
        - o = other
        - a = all
    - symbolic mode use mathematical operators to perform permission changes
        - `+` for adding permissions
        - `-` for removing permissions
        - `=` for overridding existing permissions with new value
```sh
#原 -rw-rw-rwx@   1 cyy   staff      29  7 14 21:14 HelloWorld.sh
bash-3.2$ chmod u+x,g+x,o-x HelloWorld.sh
-rwxrwxrw-@   1 cyy   staff      29  7 14 21:14 HelloWorld.sh
```
