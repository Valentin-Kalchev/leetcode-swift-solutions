/*
 Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

 Follow up: The overall run time complexity should be O(log (m+n)).

 Example 1:

 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.
 Example 2:

 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 Example 3:

 Input: nums1 = [0,0], nums2 = [0,0]
 Output: 0.00000
 Example 4:

 Input: nums1 = [], nums2 = [1]
 Output: 1.00000
 Example 5:

 Input: nums1 = [2], nums2 = []
 Output: 2.00000
 */

import Foundation

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        guard !nums1.isEmpty else {
            return medianNumber(for: nums2)
        }
        
        guard !nums2.isEmpty else {
            return medianNumber(for: nums1)
        }
        var nums3 = nums1
        nums3.append(contentsOf: nums2)
        return medianNumber(for: nums3.sorted())
    }
    
    func medianNumber(for nums: [Int]) -> Double {
        guard !nums.isEmpty else {
            return 0
        }
        
        guard !(nums.count == 1) else {
            return Double(nums[0])
        }
        
        print(nums)
        if nums.isCountEven() {
            // Even case
            let upperIndex = Int(floor(Double(nums.count) / 2))
            let lowerIndex = Int(upperIndex - 1)
            
            let lowerIndexValue = Double(nums[lowerIndex])
            let upperIndexValue = Double(nums[upperIndex])
            
            return (lowerIndexValue + upperIndexValue) / 2
        } else {
            // Odd case
            let index = Int(floor(Double(nums.count) / 2))
            return Double(nums[index])
        }
    }
}

let solution = Solution()
solution.findMedianSortedArrays([1, 2], [3, 4, 5, 6])

private extension Array {
    func isCountEven() -> Bool {
        return self.count % 2 == 0
    }
}
