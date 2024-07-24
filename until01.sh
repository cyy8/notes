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