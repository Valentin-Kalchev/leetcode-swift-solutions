/*
 Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

 Example 1:

 Input: num1 = "2", num2 = "3"
 Output: "6"
 Example 2:

 Input: num1 = "123", num2 = "456"
 Output: "56088"
 
 Note:
 - The length of both num1 and num2 is < 110.
 - Both num1 and num2 contain only digits 0-9.
 - Both num1 and num2 do not contain any leading zero, except the number 0 itself.
 - You must not use any built-in BigInteger library or convert the inputs to integer directly.

 */

import Foundation

func multiply(_ num1: String,_ num2: String) -> String {
    guard !num1.isEmpty, !num2.isEmpty else {
        fatalError()
    }
    
    switch (num1, num2) {
    case ("0", _), (_, "0"):
        return "0"
        
    case ("1", num2):
        return num2
        
    case (num1, "1"):
        return num1
        
    default:
        return multiplyPositiveNonZeroOrOneNumbers(num1, num2)
    }
}

extension String {
    func charAt(_ index: Int) -> String {
        let finalIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[finalIndex])
    }
}

private func multiplyPositiveNonZeroOrOneNumbers(_ num1: String,_ num2: String) -> String {
    
    var stringsToBeAdded = [String]()
    var numberOfZeros = num1.count - 1
 
    for digit in num1 {
        let stringToBeAdded = multiply(num: num2,
                                       singleNumber: Int(String(digit))!,
                                       numberOfZeros: numberOfZeros)
        stringsToBeAdded.append(stringToBeAdded)
        numberOfZeros = numberOfZeros - 1
    }
    
    return addStrings(stringsToBeAdded)
}

func addStrings(_ stringsToBeAdded: [String]) -> String {
    let maxNumberOfCharacters = stringsToBeAdded[0].count
    
    var finalResult = ""
    var index = 0
    var carryOver = 0
    
    while index < maxNumberOfCharacters {
        var columnAddition = 0
        
        for value in stringsToBeAdded {
            let reversedValue = String(value.reversed())
            if index < reversedValue.count {
                columnAddition = columnAddition + Int(reversedValue.charAt(index))!
            }
        }
        
        var value = columnAddition + carryOver
        
        if value > 9 {
            carryOver = value / 10
            value = value % 10
        } else {
            carryOver = 0
        }
        
        finalResult.append(String(value))
        index += 1
    }
    
    if carryOver != 0 {
        finalResult.append(String(carryOver))
    }
    
    return String(finalResult.reversed())
}

private func multiply(num: String, singleNumber: Int, numberOfZeros: Int) -> String {
    var carryOver = 0
    var resVal = ""
    
    for digit in num.reversed() {
        var value = Int(String(digit))! * singleNumber + carryOver
        if (value > 9) {
            carryOver = value / 10
            value = value % 10
        } else {
            carryOver = 0
        }
        resVal.append(String(value))
    }
    
    if carryOver != 0 {
        resVal.append(String(carryOver))
    }
    
    var finalValue = String(resVal.reversed())
    
    for _ in 0..<numberOfZeros {
        finalValue.append("0")
    }
    
    return finalValue
}

multiplyPositiveNonZeroOrOneNumbers("123", "456")

func test_multiply_by_zero() {
    if  multiply("0", "1") == "0" && multiply("1", "0") == "0" {
        print("Success")
    } else {
        fatalError()
    }
}

let result = multiply("123", "456")
