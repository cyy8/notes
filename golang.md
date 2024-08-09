
# Day 4 20240806 
## 《打开Go语言之门：入门、实战与进阶》
### 变量
- 变量简短声明“变量名 := 表达式”
`i := 10`
- 指针
    - 指针对应变量在内存中的存储位置，即指针指的值就是变量的内存地址
    - 通过`&`可以获取一个变量的地址，即指针
```go
pi := &i //pi 是指向变量i的指针
fmt.Println(*pi) //用`*pi`获取指针pi指向的变量值
```
- 赋值
`i = 20`

- 常量 const
    - go语言中，只允许布尔型、字符串、数字类型等基础类型作为常量
`const name = "飞雪无情"`

- iota
    - 常量生成器，初始值是0，可以在每个有常量声明的行后“+1”
```go
const (
		one = iota + 1 //one=(0)+1,one=1
		two     //two=(0+1)+1
		three   //……
		four
	)
	fmt.Println(one, two, three, four)
```

### 字符串和数字的转换
- `strconv`的`Itoa`可以把int转换成string；`Atoi`可以把string转换成int
```go
package main

import (
	"fmt" . 		//引入多个包时，要用括号括起来
	"strconv"
)

func main() {
	i := 20 //i定义为int20
	i2s := strconv.Itoa(i) //把int i转换成 string，并对i2s赋值
	s2i, err := strconv.Atoi(i2s)   //把string i转换回 i，并捕获可能发生的错误
	fmt.Println(i2s, s2i, err)  //打印三者
}
```

## 评分
背景：编写一个程序，允许学生输入百分比分数，60%及以上及格，60%以下不及格，并给出相应的响应
- 注释
    - 注释行：`//`，可单独一行，也可在一行代码后
    - 块注释：以`/*`开始，以`*/`结束
- Println和Print
    - `Print`打印完，信息不会跳转到新的终端行
    - `Println`打印完自动跳转到新的终端行

# Day 3 20240805 1h

## Chapter 2 条件和循环
### 调用方法
- 方法：与给定类型的值相关联的函数
- Example：time 包含了目的地址和源地址等重要信息
    - time包：包含Time类型（表示日期和时间的函数类型）
```go
package main

import (
	"fmt"
	"time"
)

func main() {
	var now time.Time = time.Now()
	var year int = now.Year()
	fmt.Println(year)
}
```
### 调用方法之 Replacer
- strings包的Replacer类型：可替换字符串中的特定字符
```sh
package main

import (
	"fmt"
	"strings"
)

func main() {
	broken := "G# r#cks!" // 短变量声明 broken是个字符串，值为“G# r#cks!”
	replacer := strings.NewReplacer("#", "o") //strings是值，NewReplacer是方法名
	fixed := replacer.Replace(broken)
	fmt.Println(fixed)

}
```

# Day 2 20240801  1h

## Chapter 1 语法基础

###  命名规则，适用变量、函数和类型的名称
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

# Day 1 20240731
### Chapter 1 语法基础
* Go：一种能快速编写代码并生成程序的语言，可以快速编译和运行
* 输出hello World
```go
package main

import "fmt"

func main() {
	fmt.Println("Hello, World!")
}
```
* Go结构
    * package句子：每个go文件都以package子句开头。package（包）是一组代码
    * imports部分：go文件有一个或多个import语句
    * 实际代码
* 调用函数：Println()，Println可以接受一个或多个参数：希望函数处理的值
* 常见函数：
    * math.Floor 对浮点数向下取最接近的整数；math.Ceil 对浮点数向上取最近的整数
    - strings.Title 拿到一个字符串，将其包含的每个单词第一个字母都变成大写，并返回大写的字符串
- 字符串：双引号之间的文本
    - 字符串的转义符：反斜杠后表示另一个字符的字符  
        | 转义序列 | 值     |    
        | ------- |-------| 
        |\n       | 换行符|
        |\t        |制表符 |
        |\"         |双引号 |
        |\\         |反斜杠|
- 符文：单个字符；而字符串是一系列文本字符
    - 符文用单引号包围，'a'；字符串用双引号包围
