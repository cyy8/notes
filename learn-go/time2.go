package main

import (
	"fmt"
	"time"
)

func main() {
	var now time.Time = time.Now()
	var month int = now.Month()    //需答疑 Month不是int，而是“January， February…… December”的合集
	var time string = now.String() //需答疑
	fmt.Println(time, month)
}
