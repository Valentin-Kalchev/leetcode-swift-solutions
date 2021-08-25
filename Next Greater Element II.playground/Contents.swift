import Foundation

/*
 Given a circular array (the next element of the last element is the first element of the array), print the Next Greater Number for every element. The Next Greater Number of a number x is the first greater number to its traversing-order next in the array, which means you could search circularly to find its next greater number. If it doesn't exist, output -1 for this number.

 Example 1:
 Input: [1,2,1]
 Output: [2,-1,2]
 Explanation: The first 1's next greater number is 2;
 The number 2 can't find next greater number;
 The second 1's next greater number needs to search circularly, which is also 2.
 Note: The length of given array won't exceed 10000.
 */
class Solution {
    
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
    
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        
        var stack = Stack()
        var res = [Int](repeating: -1, count: nums.count)
        
        for i in (0..<(nums.count * 2)).reversed() {
            let index = i % nums.count
            print("Mod: \(index)")
            while !stack.isEmpty() && nums[stack.peek()!] <= nums[index] {
                stack.pop()
            }
             
            res[index] = stack.isEmpty() ? -1 : nums[stack.peek()!]
            stack.push(index)
         }
        
        return res
    }
}

let solution = Solution()
let array = [100,1,11,1,120,111,123,1,-1,-100]
solution.nextGreaterElements(array)
