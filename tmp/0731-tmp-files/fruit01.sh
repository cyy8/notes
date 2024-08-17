#! /bin/bash
for FRUIT in apple orange banana pear
do
    echo "$FRUIT is John's favorite"
done
echo "No more fruits"

#将列表定义到一个变量中，以后有任何修改只需要修改该变量即可
fruits="apple orange banana pear"
for FRUIT in ${fruits}
do
    echo "$FRUIT is John's favorite"
done
echo "No more fruits"