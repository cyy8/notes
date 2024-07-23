#! /bin/bash
FILE=/Users/cyy/g/notes/test2.md
if [ -e $FILE ];then
    echo "$FILE exists"
else
    echo "$FILE not exists"
fi
