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
