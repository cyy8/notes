package main

import (
	"fmt" . 		//引入多个包时，要用括号括起来
	"strconv"
)

func main() {
	i := 20
	i2s := strconv.Itoa(i)
	s2i, err := strconv.Atoi(i2s)
	fmt.Println(i2s, s2i, err)

	//var bf bool = false
	//var bt bool = true
	//fmt.Println("bf is", bf, ", bt is", bt)

	//var s1 string = "Hello"
	//var s2 string = "World"
	//fmt.Println("s1 is ", s1, " s2 is ", s2)

	/*const (
		one = iota + 1
		two
		three
		four
	)
	fmt.Println(one, two, three, four)*/

}
