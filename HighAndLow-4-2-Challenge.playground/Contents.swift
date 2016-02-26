//: Playground - noun: a place where people can play

import UIKit

var array1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var array2 = [99, 49, 2, 56, 19, 63]
var array3 = [10, 10, 80, 50, 11, 80]
var array4 = [-10, 0, 50]

func highAndLow(array: [Int]) -> (high: Int, low: Int) {
    var lowestInt = Int()
    var highestInt = Int()
    
    for element in array {
        if element == array.first {
            highestInt = element
        } else {
            if element > highestInt {
                highestInt = element
            }
        }
    }
    
    for element in array {
        if element == array.first {
            lowestInt = element
        } else {
            if element < lowestInt {
                lowestInt = element
            }
        }
    }
    
    return (highestInt, lowestInt)
}

var highandlow1 = highAndLow(array1)
var hal2 = highAndLow(array2)
var hal3 = highAndLow(array3)
var hal4 = highAndLow(array4)

print("The array \(array1) has a highest number of \(highandlow1.high) and a lowest of \(highandlow1.low).")
print("The array \(array2) has a highest number of \(hal2.0) and a lowest of \(hal2.low).")
print("The array \(array3) has a highest number of \(hal3.high) and a lowest of \(hal3.low).")
print("The array \(array4) has a highest number of \(hal4.high) and a lowest of \(hal4.1).")