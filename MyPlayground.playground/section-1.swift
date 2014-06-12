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

//「Rewrite the closure to return zero for all odd numbers.」 (p.15)
numbers.map({
    (number: Int) -> Int in
    return number % 2 == 0 ? number : 0
    })

sort([1, 5, 3, 12, 2]) { $0 > $1 }


class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var shape1 = NamedShape(name:"name1")
shape1.numberOfSides = 2
shape1.simpleDescription()

let 中文 = "這是個中文  許重功"
var 誰說 = "中文棒棒"
println(中文)
誰說 = 中文 +  中文


var strValue : String?
strValue = "test"
strValue?.hashValue
strValue!.hashValue
//strValue.hashValue

var strValue2 : String! = "test2"
//strValue2 = "test"
//strValue2?.hashValue
strValue2.hashValue
