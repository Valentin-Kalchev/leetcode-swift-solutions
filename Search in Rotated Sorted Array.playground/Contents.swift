// https://leetcode.com/problems/search-in-rotated-sorted-array/

/*
 Given an integer array nums sorted in ascending order, and an integer target.

 Suppose that nums is rotated at some pivot unknown to you beforehand (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

 You should search for target in nums and if you found return its index, otherwise return -1.
 
     Example 1:

     Input: nums = [4,5,6,7,0,1,2], target = 0
     Output: 4
     Example 2:

     Input: nums = [4,5,6,7,0,1,2], target = 3
     Output: -1
     Example 3:

     Input: nums = [1], target = 0
     Output: -1
      

     Constraints:

     1 <= nums.length <= 5000
     -10^4 <= nums[i] <= 10^4
     All values of nums are unique.
     nums is guranteed to be rotated at some pivot.
     -10^4 <= target <= 10^4
 */

import Foundation

class Solution {
    private var nums: [Int] = []
    private var target = 0
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        guard !nums.isEmpty else {
            return -1
        }
        
        if nums.count == 1 {
            return nums[0] == target ? 0 : -1
        }
        
        self.nums = nums
        self.target = target
        
        let n = nums.count
        let rotate_index = findPivotIndex(0, right: n - 1)
        
        if nums[rotate_index] == target {
            return rotate_index
        }
        
        if rotate_index == 0 {
            return search(0, n - 1)
        }
        
        if target < nums[0] {
            return search(rotate_index, n - 1)
        } else {
            return search(0, rotate_index)
        }
    }
    
    private func search(_ left: Int,_ right: Int) -> Int {
        var left = left
        var right = right
        
        while left <= right {
            let pivot = (left + right) / 2
            
            if nums[pivot] == target {
                return pivot
            } else {
                if target < nums[pivot] {
                    right = pivot - 1
                } else {
                    left = pivot + 1
                }
            }
        }
        
        return -1
    }
    
    private func findPivotIndex(_ left: Int, right: Int) -> Int {
        if nums[left] < nums[right] {
            return 0
        }
        
        var left = left
        var right = right
        
        while left <= right {
            let pivot = (left + right) / 2
            
            if nums[pivot] > nums[pivot + 1] {
                return pivot + 1
            } else {
                if nums[pivot] < nums[left] {
                    right = pivot - 1
                } else {
                    left = pivot + 1
                }
            }
        }
        
        return 0
    }
}

let input = [4, 5, 6, 7, 0, 1, 2]
let target = 0
let output = 4

let solution = Solution()
if solution.search(input, target) != output {
    print("Fail")
}
