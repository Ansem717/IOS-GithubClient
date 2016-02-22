//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func middleThreeElements(array: [Int]) -> [Int] {
    var tempArray = array
    let length = array.count
    
    let isEven = ( (length/2)*2 == length ) //Since Intergers can't have a decimal point, dividing an odd Interger by two does not result in an X.5, but instead it
                                            //rounds down. Therefore, dividing 11 by 2 yeilds 5.5, but rounded down is 5. Multiply that by 2 equals 10. We then compare the final result (10) with the original input (11) and if these two are not equal, then the original number is odd. Since the definition of an even number is that it can be divided by 2 without a decimal, rounding that number down doesn't do anything, but it's already a whole number. Thus, the even number's final result will equal the original numbers' final result. This only works with Intergers, however, since once we move to Doubles, the numbers will no long automatically round down.
    
    if isEven || length < 3 {
        print("The array's length must be ODD and have 3 OR MORE elements. Your array's length is \(length)")
        return array
    } else {
        while tempArray.count > 3 {
            tempArray.removeFirst()
            tempArray.removeLast()
        }
        return tempArray
    }
}

var array1 = [100, 100, 100, 7, 7, 7, 100, 100, 100]
var array2 = [1, 2, 3, 4, 5, 6, 7, 8]
var array3 = [1, 2, 3]
var array4 = [1]
var array5 = [1, 2, 3, 4, 5, 6, 7]

middleThreeElements(array1)
middleThreeElements(array2)
middleThreeElements(array3)
middleThreeElements(array4)
middleThreeElements(array5)