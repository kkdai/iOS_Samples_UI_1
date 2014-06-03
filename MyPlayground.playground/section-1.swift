// Playground - noun: a place where people can play

import Cocoa

//var is for variable, let for constant (not change)
var str = "Hello, playground"
let str2 = "test 2"
str = "test 3 "

//for in
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
teamScore

//tuple multiple return.
func getGasPrices() -> (Double, Double, Double) {
    return (3.59, 3.69, 3.79)
}
getGasPrices()

// parameter
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)

func avgOf(numbers: Int...) -> Int {
    var sum = 0
    var num = 0
    for number in numbers {
        sum += number
        num++
    }
    return sum/num
}

avgOf(42, 597, 12)


var numbers = [20, 19, 7, 12]
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
    })

//「Rewrite the closure to return zero for all odd numbers.」
numbers.map({
    (number: Int) -> Int in
    return number % 2 == 0 ? number : 0
    })