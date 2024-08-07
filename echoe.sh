#!/bin/bash
fruit=apple count=5 
# fruit是变量名，apple是赋给变量的值，如果value不包含空白字符，就不需要加引号，否则要加单引号或双引号
# 赋值等号前后没有空格
echo "We have $count ${fruit}s"
# `echo $var`可以访问变量的内容，或者`echo ${var}`