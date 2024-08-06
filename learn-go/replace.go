package main

import (
	"fmt"
	"strings"
)

func main() {
	broken := "G# r#cks!"                     // 短变量声明 broken是个字符串，值为“G# r#cks!”
	replacer := strings.NewReplacer("#", "o") //strings是值，NewReplacer是方法名
	fixed := replacer.Replace(broken)
	fmt.Println(fixed)

}
