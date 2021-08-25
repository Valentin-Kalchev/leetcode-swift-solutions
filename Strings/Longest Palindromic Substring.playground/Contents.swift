/*
     Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

     Example 1:

     Input: "babad"
     Output: "bab"
     Note: "aba" is also a valid answer.
     Example 2:

     Input: "cbbd"
     Output: "bb"
 */

import Foundation

class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 1 else {
            return s
        }
        
        var start = 0
        var end = 0
        
        for i in 0..<s.count {
            let len1 = expandAroundCenter(s, left: i, right: i)
            let len2 = expandAroundCenter(s, left: i, right: i + 1)
            
            let len = max(len1, len2)
            if len > end - start {
                start = i - (len - 1) / 2
                end = i + len / 2
            }
        }
        
        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(s.startIndex, offsetBy: end)
        
        return String(s[startIndex...endIndex])
    }
    
    private func expandAroundCenter(_ s: String, left: Int, right: Int) -> Int {
        var l = left
        var r = right
        
        while l >= 0 && r < s.count && s[s.index(s.startIndex, offsetBy: l)] == s[s.index(s.startIndex, offsetBy: r)] {
            l -= 1
            r += 1
        }
        print("r: \(r), l: \(l), \(r-l-1)")
        return r - l - 1
    }
}

let solution = Solution()
let output = solution.longestPalindrome("amanamrs")

if output != "manam" {
    print("Fail")
}
//
//if solution.longestPalindrome("asdfghgfdsa") != "asdfghgfdsa" {
//    print("Fail")
//}
//
//
//if solution.longestPalindrome("a") != "a" {
//    print("Fail")
//}
//
//
//if solution.longestPalindrome("asdfghjkjhgfoper") != "fghjkjhgf" {
//    print("Fail")
//}
