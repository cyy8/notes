# Day 1 20240731
# Day 2 20240801  1h
### Chapter 1 语法基础
* 命名规则，适用变量、函数和类型的名称
    - 强制规定
        - 名称必须以**字母**开头，且可以有任意数量的额外字母和数字
        - 以**大写字母开头**的变量、函数或类型，默认其是导出的，可以在当前包之外的包访问；反之，以小写字母开头，则是未导出的，仅可在当前包中使用
    - 额外约定
        - 驼峰大小写：若一个名称由多个单词组成，则第一个单词后的**每个单词**首字母都要大写，且之间没有空格
            - topPrice, RetryConnection
        - 习惯性缩写：若某个名称的含义在上下文中很明显，Go社区习惯缩写
            - i - index; max - maximum （not for beginners）
- 转换
    - Go中的数学和比较运算，要求包含的值是相同的类型，不然会报错
    ```go
    package main
    import "fmt"

    func main() {
	var price int = 100
	fmt.Println("Price is", price, "dollars") //不涉及运算，price不需要转换
	var taxRate float64 = 0.08
	var tax float64 = float64(price) * taxRate //price（int）涉及与taxRate（float64）的运算，需转换
	fmt.Println("Tax is", tax, "dollars.")
	var total float64 = float64(price) + tax  //同上
	fmt.Println("Total coast is", total, "dollars.")
	var availableFunds int = 120
	fmt.Println("Within budget?", int(total) <= availableFunds) //total（float64）与availableFunds（int）比较，需转换
}
    ```
    
- Go 工具
    - go build 将源代码文件编译成二进制文件
    - go run 编译并运行，而不保存可执行文件
    - go fmt 使用Go标准格式重新格式化源文件
        - 即可将纯文本文件转化为Go标准格式的文件，但注意文件名扩展名需改为go
    - go version 显示当前Go版本号