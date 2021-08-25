// Given an array of integers and an integer k, you need to find the total number of continuous subarrays whose sum equals to k.
// Input:nums = [1, 1, 1], k = 2
// Output: 2

// Scenario: 1
//let input = [1, -1, 5, -2, 3]
//let k = 3
//let output = 3

// Scenario: 2
// let input = [1]
// let k = 1
// let output = 1

// Scenario: 3
let input = [3, 4, 7, 2, -3, 1, 4, 2]
let k = 7
let output = 4

// Approach 1: Brute force approach - iterate over every possible subarray - Time: 0(n3), Space: 0(1)
/*
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        
        // Space: 0(1) constant
        for start in 0..<nums.count {
            // Time: O(n)
            for end in start + 1...nums.count {
                // Time: O(n)
                var sum = 0
                
                for i in start..<end {
                    // Time: O(n)
                    sum += nums[i]
                }
                
                if sum == k {
                    print("Start: \(start) End: \(end) Sum: \(sum)")
                    count += 1
                }
            }
        }
        
        return count
    }
}
*/

// Approach 2: Using Cumulative Sum
/*
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        var sum: [Int] = [0] + nums
        
        // Time: O(1)
        for i in 1...nums.count {
            sum[i] = sum[i - 1] + nums[i - 1]
        }
        
        for start in 0..<nums.count {
            for end in start...nums.count {
                if sum[end] - sum[start] == k {
                    count += 1
                }
            }
        }
        
        return count
    }
}
*/
 
// Approach 3: Without Space - Time complexity 0(n2) we need to consider every subarray possible, space complexity O(1) constant space used
/*
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var count = 0
        
        for start in 0..<nums.count {
            var sum = 0
            
            for end in start..<nums.count {
                sum += nums[end]
                if sum == k {
                    count += 1
                }
            }
        }
        return count
    }
}
 */


// Approach 4: Using Hashmap
class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var counter = 0
        var dict: [Int:Int] = [0:1]
        var sum = 0
        for i in 0..<nums.count {
            sum += nums[i] 
            
            if let count = dict[sum - k] {
                counter += count
            }
            
            if let value = dict[sum] {
                dict[sum] = value + 1
            } else {
                dict[sum] = 1
            }
            
            print("Sum: \(sum) Dict: \(dict)")
        }
        return counter
    }
}

let solution = Solution()

let result = solution.subarraySum(input, k)

if result != output {
    print("Fail: \(result)")
}
