package main

import (
	"fmt"
	"reflect"
)

func main() {
	fmt.Println(reflect.TypeOf(42), reflect.TypeOf(1.0), reflect.TypeOf(true), reflect.TypeOf("true"), reflect.TypeOf('A'))
}

// Println可跟多个参数值，用逗号隔开
// int 和 int32
