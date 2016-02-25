//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var str2 = "The"
var str3 = "The quick brown fox"
var str4 = "The quick brown fox jumps over the lazy dog"

func doubleChar(text: String) -> String {
    var newStr = ""
    for char in text.characters {
        newStr.append(char)
        newStr.append(char)
    }
    return newStr
}

print(doubleChar(str))
print(doubleChar(str2))
print(doubleChar("")) //This displays nothing, and is noticable due to the empty line in the console.
print(doubleChar(str3))
print(doubleChar(str4))
