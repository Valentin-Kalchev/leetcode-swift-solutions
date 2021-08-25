/*
 Given a string s, find the length of the longest substring without repeating characters.
*/

import Foundation

let input = "pwwkew"
let expectedOutput = 3

// Approach: Sliding Window
/*
class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var set = Set<String>()
        let n = s.count
        var ans = 0
        var i = 0
        var j = 0
        
        while i < n && j < n {
            var index = s.index(s.startIndex, offsetBy: j)
            
            if !set.contains(String(s[index])) {
                index = s.index(s.startIndex, offsetBy: j)
                set.insert(String(s[index]))
                
                j += 1
                ans = max(ans, j - i)
                
            } else {
                index = s.index(s.startIndex, offsetBy: i)
                set.remove(String(s[index]))
                i += 1
            }
        }
        
        return ans
    }
}
 */

// Approach: Sliding Window Optimized

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let totalCountOfCharacters = s.count
        var lengthOfLongestString = 0
        var dictionaryHoldingCharacters = [Character: Int]()
        
        var i = 0
        
        for j in 0..<totalCountOfCharacters {
            let index = s.index(s.startIndex, offsetBy: j)
            
            if let value = dictionaryHoldingCharacters[s[index]] {
                i = max(value, i)
            }
            
            lengthOfLongestString = max(lengthOfLongestString, j - i + 1)
            dictionaryHoldingCharacters[s[index]] = j + 1
        }
        
        return lengthOfLongestString
    }
}
 
if Solution().lengthOfLongestSubstring(input) != expectedOutput {
    print("Failed")
}
