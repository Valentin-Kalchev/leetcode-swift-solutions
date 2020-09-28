/*
 Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.

 A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.
 
 Example:

 Input: "23"
 Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].

 */
import Foundation

class Solution {
    private func lettersForDigit(_ digit: String) -> String {
        switch digit {
            case "2": return "abc"
            case "3": return "def"
            case "4": return "ghi"
            case "5": return "jkl"
            case "6": return "mno"
            case "7": return "pqrs"
            case "8": return "tuv"
            case "9": return "wxyz"
            default: return ""
        }
    }
    
    var output: [String] = []
    
    private func backtrack(combination: String, nextDigits: String) {
        if nextDigits.isEmpty {
            output.append(combination)
        } else {
            let startIndex = nextDigits.startIndex
            let endIndex = nextDigits.index(nextDigits.startIndex, offsetBy: 1)
            let digit = nextDigits[startIndex..<endIndex]
             
            let letters = letterCombinations(String(digit))
            print(letters)
            for i in 0..<letters.count {
                let lettersCombination = lettersForDigit(String(digit))
                
                let startIndex = lettersCombination.index(lettersCombination.startIndex, offsetBy: i)
                let endIndex = lettersCombination.index(startIndex, offsetBy: i + 1)
                let letter = lettersCombination[lettersCombination.startIndex..<endIndex]
                
                let newDigitsStartIndex = nextDigits.index(nextDigits.startIndex, offsetBy: 1)
                let newDigits = nextDigits[newDigitsStartIndex..<nextDigits.endIndex]
                print("newDigits: \(newDigits)")
                backtrack(combination: combination + String(letter), nextDigits: String(newDigits))
            }
        }
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        if !digits.isEmpty {
            backtrack(combination: "", nextDigits: digits)
        }
        return output
    }
}

let input = "23"
let expectedOutput = Set<String>(["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"])

let solution = Solution()
let output = Set<String>(solution.letterCombinations(input))

if output != expectedOutput {
    print("Fail, got \(output)")
}


