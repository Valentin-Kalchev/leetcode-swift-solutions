import Foundation

/*
     Given two integers dividend and divisor, divide two integers without using multiplication, division and mod operator.

     Return the quotient after dividing dividend by divisor.

     The integer division should truncate toward zero, which means losing its fractional part. For example, truncate(8.345) = 8 and truncate(-2.7335) = -2.

     Example 1:

     Input: dividend = 10, divisor = 3
     Output: 3
     Explanation: 10/3 = truncate(3.33333..) = 3.
     Example 2:

     Input: dividend = 7, divisor = -3
     Output: -2
     Explanation: 7/-3 = truncate(-2.33333..) = -2.
     Note:

     Both dividend and divisor will be 32-bit signed integers.
     The divisor will never be 0.
     Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your function returns 231 − 1 when the division result overflows.
*/

class Solution {

// Approach 1 - Iteration
/*
    class Solution {
        func divide(_ dividend: Int, _ divisor: Int) -> Int {
            
            var dividend = dividend
            var divisor = divisor
            
            if dividend == Int.min && divisor == -1 {
                return Int.max
            }
            
            var negatives = 2
            
            if dividend > 0 {
                negatives -= 1
                dividend = -dividend
            }
            
            if divisor > 0 {
                negatives -= 1
                divisor = -divisor
            }
            
            var quotient = 0
            while dividend - divisor <= 0 {
                quotient -= 1
                dividend -= divisor
            }
            
            if negatives != 1 {
                quotient = -quotient
            }
            
            return quotient
        }
*/
    
/*
// Approach 2 - Repeated Exponential Searches
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        var dividend = dividend
        var divisor = divisor

        if dividend == Int.min && divisor == -1 {
            return Int.max
        }

        var negatives = 2

        if dividend > 0 {
            negatives -= 1
            dividend = -dividend
        }

        if divisor > 0 {
            negatives -= 1
            divisor = -divisor
        }
        
        var quotient = 0
        let halfIntMax = -Int.max / 2
        
        while divisor >= dividend {
            var powerOfTwo = -1
            var value = divisor
            
            while value >= halfIntMax && value + value >= dividend {
                value += value
                powerOfTwo += powerOfTwo
            }
            
            quotient += powerOfTwo
            dividend -= value
        }
        
        if negatives != 1 {
            return -quotient
        } else {
            return quotient
        }
    }
*/
    
/*
    // Approach 3: Adding Powers of Two
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        var dividend = dividend
        var divisor = divisor

        if dividend == Int.min && divisor == -1 {
            return Int.max
        }

        var negatives = 2

        if dividend > 0 {
            negatives -= 1
            dividend = -dividend
        }

        if divisor > 0 {
            negatives -= 1
            divisor = -divisor
        }
        
        let halfIntMax = -Int.max / 2
        
        var doubles = [Int]()
        var powersOfTwo = [Int]()
        
        var powerOfTwo = -1
        
        while divisor >= dividend {
            doubles.append(divisor)
            powersOfTwo.append(powerOfTwo)
            
            if divisor < halfIntMax {
                break;
            }
            
            divisor += divisor
            powerOfTwo += powerOfTwo
        }
        
        var quotient = 0
        
        for i in (0..<doubles.count).reversed() {
            if doubles[i] >= dividend {
                quotient += powersOfTwo[i]
                dividend -= doubles[i]
            }
        }
        
        return negatives != 1 ? -quotient : quotient
    }
*/
    
/*
    // Approach 4: Adding Powers of Two with Bit-Shifting
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        var dividend = dividend
        var divisor = divisor
        
        if dividend == Int.max && divisor == -1 {
            return Int.min
        }
        
        var negatives = 2
        
        if dividend > 0 {
            dividend = -dividend
            negatives -= 1
        }
        
        if divisor > 0 {
            divisor = -divisor
            negatives -= 1
        }
        
        let halfIntMax = -Int.max / 2
        
        var highestDouble = divisor
        var highestPowerOfTwo = -1
        
        while highestDouble >= halfIntMax && dividend <= highestDouble + highestDouble {
            highestPowerOfTwo += highestPowerOfTwo
            highestDouble += highestDouble
        }
        
        var quotient = 0
        
        while dividend <=  divisor {
            if dividend <= highestDouble {
                quotient += highestPowerOfTwo
                dividend -= highestDouble
            }
            
            highestPowerOfTwo >>= 1
            highestDouble >>= 1
        }
        
        return negatives != 1 ? -quotient : quotient
    }
     */
    
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        if dividend == Int.max && divisor == -1 {
            return Int.min
        }
        var divisor = divisor
        var dividend = dividend
        
        var negatives = 2
        if dividend > 0 {
            dividend = -dividend
            negatives -= 1
        }
        
        if divisor > 0 {
            divisor = -divisor
            negatives -= 1
        }
        
        var powerOfTwo = -1
        var powersOfTwo = [Int]()
        var doubles = [Int]()
        
        let halfIntMax = -Int.max / 2
        
        while divisor >= dividend {
            doubles.append(divisor)
            powersOfTwo.append(powerOfTwo)
            
            if divisor < halfIntMax {
                break;
            }
            
            divisor += divisor
            powerOfTwo += powerOfTwo
        }
        
        var quotient = 0
        
        for i in (0..<doubles.count).reversed() {
            if doubles[i] >= dividend {
                dividend -= doubles[i]
                quotient += powersOfTwo[i]
            }
        }
        
        return negatives != 1 ? -quotient : quotient
    }
}

let solution = Solution()
if solution.divide(123, 1) != 123 {
    print("Fail")
}
 
if  solution.divide(-100, -2) != 50 {
    print("Fail")
}

if solution.divide(Int.min, -1) != Int.max {
    print("Fail")
}

if solution.divide(-2147483648, -1) != 2147483648 {
    print("Fail")
}
