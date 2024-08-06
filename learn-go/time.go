package main

import (
	"fmt"
	"time" //导入“time包“，以便使用 time.Time 类型
)

func main() {
	var now time.Time = time.Now()
	// ⬆️time.Now返回一个代表当前日期和时间的time.Time值，该值存储到 now 变量中
	var year int = now.Year()
	// 对now引用的值（也就是time.Time的值），调用Year方法
	// Year方法返回一个int整数
	fmt.Println(year)
	// 打印该整数
}
