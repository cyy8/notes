package main

import "fmt"

func main() {
	var length float64 = 4.5
	var width int = 2
	//widthFloat := float64(width) // 将width从int转换为float64 #相当于新创建了一个变量？
	fmt.Println(length*float64(width), "square meters")
}
