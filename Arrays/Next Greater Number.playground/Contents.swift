/*
 You are given two arrays (without duplicates) nums1 and nums2 where nums1’s elements are subset of nums2. Find all the next greater numbers for nums1's elements in the corresponding places of nums2.

The Next Greater Number of a number x in nums1 is the first greater number to its right in nums2. If it does not exist, output -1 for this number.

Example 1:
Input: nums1 = [4,1,2], nums2 = [1,3,4,2].
Output: [-1,3,-1]
Explanation:
    For number 4 in the first array, you cannot find the next greater number for it in the second array, so output -1.
    For number 1 in the first array, the next greater number for it in the second array is 3.
    For number 2 in the first array, there is no next greater number for it in the second array, so output -1.
Example 2:
Input: nums1 = [2,4], nums2 = [1,2,3,4].
Output: [3,-1]
Explanation:
    For number 2 in the first array, the next greater number for it in the second array is 3.
    For number 4 in the first array, there is no next greater number for it in the second array, so output -1.
Note:
All elements in nums1 and nums2 are unique.
The length of both nums1 and nums2 would not exceed 1000.
*/


import Foundation

let arr1 = [4,1,2]
let arr2 = [1,3,4,2]
let expectedOutput = [-1,3,-1]

// Approach #1: Brute Force
/*
class Solution {
    func nextGreaterElement(_ arr1: [Int], arr2: [Int]) -> [Int] {
        var output = [Int]()
        
        for num1 in arr1 {
            var found = false
            for (num2Index, num2) in arr2.enumerated() {
                if (num1 == num2) {
                    for index in num2Index + 1..<arr2.count {
                        let num = arr2[index]
                        
                        if num > num1 {
                            output.append(num)
                            found = true
                            break
                        }
                    }
                    break
                }
            }
            
            if !found {
                output.append(-1)
            }
        }
        
        return output
    }
}
*/

// Approach #2 Better Brute Force
/*
class Solution {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var res = [Int]()
        var hash: [Int: Int] = [:]
        
        for i in 0..<nums2.count {
            hash[nums2[i]] = i
        }
        
        print(hash)
        
        for num1 in nums1 {
            for j in hash[num1]!..<nums2.count {
                let num2 = nums2[j]
                
                if num1 < num2 {
                    res.append(num2)
                    break
                    
                }
                
                if j == nums2.count - 1 {
                    res.append(-1)
                }
            }
        }
        
        return res
    }
}
*/

// Approach #3 - Using Stack

struct Stack {
    private var array: [Int] = []
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int? {
        return array.popLast()
    }
    
    func peek() -> Int? {
        return array.last
    }
    
    func isEmpty() -> Bool {
        return array.isEmpty
    }
} 

class Solution {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack = Stack()
        var hash: [Int: Int] = [:]
        var results = [Int]()
        
        for (i, num2) in nums2.enumerated() {
            while !stack.isEmpty() && num2 > stack.peek()! {
                hash[stack.pop()!] = num2
            }
            stack.push(num2)
        }
        
        while !stack.isEmpty() {
            hash[stack.pop()!] = -1
        }

        print(hash)
        for i in 0..<nums1.count {
            results.append(hash[nums1[i]]!)
        }
        
        return results
    }
}
let solution = Solution()
let output = solution.nextGreaterElement(arr1, arr2)

if output != expectedOutput {
    print("Fail")
}

