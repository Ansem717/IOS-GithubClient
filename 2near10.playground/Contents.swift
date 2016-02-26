//: Playground - noun: a place where people can play

import UIKit

func twoWithinTen(num: Int) -> Bool {
    
    if num < 0 {
        print("Your number is negative!")
        return false
    }
    let twoWithinTenArray = [8, 9, 0, 1, 2]
    
    for compareNum in twoWithinTenArray {
        if num % 10 == compareNum {
            return true
        }
    }
    
    return  false
}

twoWithinTen(10) //true, as 10 is simply evenly divisible.
twoWithinTen(7) //false, since 7 is three numbers away from 10.
twoWithinTen(45) //false, since 45 is five numbers away from 40 or 50.
twoWithinTen(14209) //true, since 14209 is one number away from 14210
twoWithinTen(71) //true, since 71 is one number away from 70
twoWithinTen(-50) //fasle with print, since number is negative.


